import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CardDetailContent extends StatefulWidget {
  final List<CameraDescription> cameras;
  // final DataCards dataCards;
  CardDetailContent(this.cameras);

  @override
  _CardDetailContentState createState() => _CardDetailContentState();
}

class _CardDetailContentState extends State<CardDetailContent> with WidgetsBindingObserver {
  String imagePath;
  bool _toggleCamera = false;
  CameraController controller;

  @override
  void initState() {
    try {
      onCameraSelected(widget.cameras[0]);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // App state changed before we got the chance to initialize.
  //   if (controller == null || !controller.value.isInitialized) {
  //     return;
  //   }
  //   if (state == AppLifecycleState.inactive) {
  //     controller?.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (controller != null) {
  //       onNewCameraSelected(controller.description);
  //     }
  //   }
  // }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.cameras.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No Camera Found',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      );
    }

    if (!controller.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Container(
        child: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 120.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(00, 00, 00, 0.7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          onTap: () {
                            if (!_toggleCamera) {
                              onCameraSelected(widget.cameras[1]);
                              setState(() {
                                _toggleCamera = true;
                              });
                            } else {
                              onCameraSelected(widget.cameras[0]);
                              setState(() {
                                _toggleCamera = false;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            child: Image.asset(
                              'assets/images/ic_switch_camera_3.png',
                              color: Colors.grey[200],
                              width: 42.0,
                              height: 42.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          onTap: () {
                            _captureImage();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            child: Image.asset(
                              'assets/images/ic_shutter_1.png',
                              width: 72.0,
                              height: 72.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showException(e);
    }

    if (mounted) setState(() {});
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void _captureImage() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          showMessage('Picture saved to $filePath');
          setCameraResult();
        }
      }
    });
  }

  void setCameraResult() {
    Navigator.pop(context, imagePath);
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showMessage('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/FlutterDevs/Camera/Images';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      showException(e);
      return null;
    }
    return filePath;
  }

  void showException(CameraException e) {
    logError(e.code, e.description);
    showMessage('Error: ${e.code}\n${e.description}');
  }

  void showMessage(String message) {
    print(message);
  }

  void logError(String code, String message) => print('Error: $code\nMessage: $message');
}

/// Display the preview from the camera (or a message if the preview is not available).
// Widget _cameraPreviewWidget() {
//   if (controller == null || !controller.value.isInitialized) {
//     return const Text(
//       'Tap a camera',
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 24.0,
//         fontWeight: FontWeight.w900,
//       ),
//     );
//   } else {
//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: Stack(
//         children: [
//           CameraPreview(controller),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//                 width: double.infinity,
//                 height: 120.0,
//                 padding: EdgeInsets.all(20.0),
//                 color: Color.fromRGBO(00, 00, 00, 0.7),
//                 child: Stack(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.center,
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                           onTap: () {
//                             // _captureImage();
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(4.0),
//                             child: Image.asset(
//                               'assets/images/ic_shutter_1.png',
//                               width: 72.0,
//                               height: 72.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                           onTap: () {
//                             if (!_toggleCamera) {
//                               onCameraSelected(widget.cameras[1]);
//                               setState(() {
//                                 _toggleCamera = true;
//                               });
//                             } else {
//                               onCameraSelected(widget.cameras[0]);
//                               setState(() {
//                                 _toggleCamera = false;
//                               });
//                             }
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(4.0),
//                             child: Image.asset(
//                               'assets/images/ic_switch_camera_3.png',
//                               color: Colors.grey[200],
//                               width: 42.0,
//                               height: 42.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),),
//           ),
//         ],
//       ),
//     );
//   }
// }

//   /// Toggle recording audio
//   Widget _toggleAudioWidget() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 25),
//       child: Row(
//         children: <Widget>[
//           const Text('Enable Audio:'),
//           Switch(
//             value: enableAudio,
//             onChanged: (bool value) {
//               enableAudio = value;
//               if (controller != null) {
//                 onNewCameraSelected(controller.description);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   /// Display the thumbnail of the captured image or video.
//   Widget _thumbnailWidget() {
//     return Expanded(
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             videoController == null && imagePath == null
//                 ? Container()
//                 : SizedBox(
//                     child: (videoController == null)
//                         ? Image.file(File(imagePath))
//                         : Container(
//                             child: Center(
//                               child: AspectRatio(
//                                   aspectRatio: videoController.value.size != null
//                                       ? videoController.value.aspectRatio
//                                       : 1.0,
//                                   child: VideoPlayer(videoController)),
//                             ),
//                             decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
//                           ),
//                     width: 64.0,
//                     height: 64.0,
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Display the control bar with buttons to take pictures and record videos.
//   Widget _captureControlRowWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.camera_alt),
//           color: Colors.blue,
//           onPressed: controller != null &&
//                   controller.value.isInitialized &&
//                   !controller.value.isRecordingVideo
//               ? onTakePictureButtonPressed
//               : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.videocam),
//           color: Colors.blue,
//           onPressed: controller != null &&
//                   controller.value.isInitialized &&
//                   !controller.value.isRecordingVideo
//               ? onVideoRecordButtonPressed
//               : null,
//         ),
//         IconButton(
//           icon: controller != null && controller.value.isRecordingPaused
//               ? Icon(Icons.play_arrow)
//               : Icon(Icons.pause),
//           color: Colors.blue,
//           onPressed: controller != null &&
//                   controller.value.isInitialized &&
//                   controller.value.isRecordingVideo
//               ? (controller != null && controller.value.isRecordingPaused
//                   ? onResumeButtonPressed
//                   : onPauseButtonPressed)
//               : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.stop),
//           color: Colors.red,
//           onPressed: controller != null &&
//                   controller.value.isInitialized &&
//                   controller.value.isRecordingVideo
//               ? onStopButtonPressed
//               : null,
//         )
//       ],
//     );
//   }

//   /// Display a row of toggle to select the camera (or a message if no camera is available).
//   Widget _cameraTogglesRowWidget() {
//     final List<Widget> toggles = <Widget>[];

//     if (cameras.isEmpty) {
//       return const Text('No camera found');
//     } else {
//       for (CameraDescription cameraDescription in cameras) {
//         toggles.add(
//           SizedBox(
//             width: 90.0,
//             child: RadioListTile<CameraDescription>(
//               title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
//               groupValue: controller?.description,
//               value: cameraDescription,
//               onChanged: controller != null && controller.value.isRecordingVideo
//                   ? null
//                   : onNewCameraSelected,
//             ),
//           ),
//         );
//       }
//     }

//     return Row(children: toggles);
//   }

//   String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

//   void onCameraSelected(CameraDescription cameraDescription) async {
//     if (controller != null) await controller.dispose();
//     controller = CameraController(cameraDescription, ResolutionPreset.medium);

//     controller.addListener(() {
//       if (mounted) setState(() {});
//       if (controller.value.hasError) {
//         showMessage('Camera Error: ${controller.value.errorDescription}');
//       }
//     });

//     try {
//       await controller.initialize();
//     } on CameraException catch (e) {
//       showException(e);
//     }

//     if (mounted) setState(() {});
//   }

//   void showException(CameraException e) {
//     logError(e.code, e.description);
//     showMessage('Error: ${e.code}\n${e.description}');
//   }

//   void showMessage(String message) {
//     print(message);
//   }

//   void logError(String code, String message) => print('Error: $code\nMessage: $message');

//   void showInSnackBar(String message) {
//     // ignore: deprecated_member_use
//     _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
//   }

//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     if (controller != null) {
//       await controller.dispose();
//     }
//     controller = CameraController(
//       cameraDescription,
//       ResolutionPreset.medium,
//       enableAudio: enableAudio,
//     );

//     // If the controller is updated then update the UI.
//     controller.addListener(() {
//       if (mounted) setState(() {});
//       if (controller.value.hasError) {
//         showInSnackBar('Camera error ${controller.value.errorDescription}');
//       }
//     });

//     try {
//       await controller.initialize();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void onTakePictureButtonPressed() {
//     takePicture().then((String filePath) {
//       if (mounted) {
//         setState(() {
//           imagePath = filePath;
//           videoController?.dispose();
//           videoController = null;
//         });
//         if (filePath != null) showInSnackBar('Picture saved to $filePath');
//       }
//     });
//   }

//   void onVideoRecordButtonPressed() {
//     startVideoRecording().then((String filePath) {
//       if (mounted) setState(() {});
//       if (filePath != null) showInSnackBar('Saving video to $filePath');
//     });
//   }

//   void onStopButtonPressed() {
//     stopVideoRecording().then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Video recorded to: $videoPath');
//     });
//   }

//   void onPauseButtonPressed() {
//     pauseVideoRecording().then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Video recording paused');
//     });
//   }

//   void onResumeButtonPressed() {
//     resumeVideoRecording().then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Video recording resumed');
//     });
//   }

//   Future<String> startVideoRecording() async {
//     if (!controller.value.isInitialized) {
//       showInSnackBar('Error: select a camera first.');
//       return null;
//     }

//     final Directory extDir = await getApplicationDocumentsDirectory();
//     final String dirPath = '${extDir.path}/Movies/flutter_test';
//     await Directory(dirPath).create(recursive: true);
//     final String filePath = '$dirPath/${timestamp()}.mp4';

//     if (controller.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return null;
//     }

//     try {
//       videoPath = filePath;
//       await controller.startVideoRecording(filePath);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//     return filePath;
//   }

//   Future<void> stopVideoRecording() async {
//     if (!controller.value.isRecordingVideo) {
//       return null;
//     }

//     try {
//       await controller.stopVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }

//     await _startVideoPlayer();
//   }

//   Future<void> pauseVideoRecording() async {
//     if (!controller.value.isRecordingVideo) {
//       return null;
//     }

//     try {
//       await controller.pauseVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }

//   Future<void> resumeVideoRecording() async {
//     if (!controller.value.isRecordingVideo) {
//       return null;
//     }

//     try {
//       await controller.resumeVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }

//   Future<void> _startVideoPlayer() async {
//     final VideoPlayerController vcontroller = VideoPlayerController.file(File(videoPath));
//     videoPlayerListener = () {
//       if (videoController != null && videoController.value.size != null) {
//         // Refreshing the state to update video player with the correct ratio.
//         if (mounted) setState(() {});
//         videoController.removeListener(videoPlayerListener);
//       }
//     };
//     vcontroller.addListener(videoPlayerListener);
//     await vcontroller.setLooping(true);
//     await vcontroller.initialize();
//     await videoController?.dispose();
//     if (mounted) {
//       setState(() {
//         imagePath = null;
//         videoController = vcontroller;
//       });
//     }
//     await vcontroller.play();
//   }

//   Future<String> takePicture() async {
//     if (!controller.value.isInitialized) {
//       showInSnackBar('Error: select a camera first.');
//       return null;
//     }
//     final Directory extDir = await getApplicationDocumentsDirectory();
//     final String dirPath = '${extDir.path}/Pictures/flutter_test';
//     await Directory(dirPath).create(recursive: true);
//     final String filePath = '$dirPath/${timestamp()}.jpg';

//     if (controller.value.isTakingPicture) {
//       // A capture is already pending, do nothing.
//       return null;
//     }

//     try {
//       await controller.takePicture(filePath);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//     return filePath;
//   }

//   void _showCameraException(CameraException e) {
//     logError(e.code, e.description);
//     showInSnackBar('Error: ${e.code}\n${e.description}');
//   }
// }

// /// Returns a suitable camera icon for [direction].
// IconData getCameraLensIcon(CameraLensDirection direction) {
//   switch (direction) {
//     case CameraLensDirection.back:
//       return Icons.camera_rear;
//     case CameraLensDirection.front:
//       return Icons.camera_front;
//     case CameraLensDirection.external:
//       return Icons.camera;
//   }
//   throw ArgumentError('Unknown lens direction');
// }

// void logError(String code, String message) => print('Error: $code\nError Message: $message');
