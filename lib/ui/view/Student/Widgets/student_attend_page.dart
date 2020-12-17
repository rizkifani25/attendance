import 'dart:io';
import 'package:attendance/models/models.dart';
import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StudentAttendPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Student student;
  final String roomId;
  final String time;

  StudentAttendPage({this.cameras, this.student, this.roomId, this.time});

  @override
  _StudentAttendPageState createState() => _StudentAttendPageState();
}

class _StudentAttendPageState extends State<StudentAttendPage> with WidgetsBindingObserver {
  String imagePath;
  bool _toggleCamera = false;
  CameraController controller;
  PanelController _pc1 = new PanelController();
  Position position;
  double _distance;

  @override
  void initState() {
    _getCurrentPosition();
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onCameraSelected(controller.description);
      }
    }
  }

  void _getCurrentPosition() async {
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          latitudeBuildingB,
          longitudeBuildingB,
        );
      });
    } catch (e) {}
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
    takePicture().then((String filePath) async {
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
    // Navigator.pop(context, imagePath);
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showMessage('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/Camera/Images';
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

  void _handleAttendButton({BuildContext parentContext}) async {
    if (imagePath != null) {
      AttendStudent _attendStudent = new AttendStudent();
      PositionStudent _positionStudent = new PositionStudent();

      _attendStudent.distance = _distance;
      _attendStudent.image = imagePath;

      _positionStudent.latitude = position.latitude;
      _positionStudent.longitude = position.longitude;

      _attendStudent.positionStudent = _positionStudent;
      _attendStudent.time = DateTime.now();

      return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return CustomDialogBox(
            children: [
              SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Are you sure want to attend the class?',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<StudentBloc>(context).add(
                      StudentDoAttend(
                        attendStudent: _attendStudent,
                        roomId: widget.roomId,
                        studentId: widget.student.studentId,
                        time: widget.time,
                      ),
                    );
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleOutButton({BuildContext parentContext}) async {
    if (imagePath != null) {
      OutStudent _outStudent = new OutStudent();
      PositionStudent _positionStudent = new PositionStudent();

      _outStudent.distance = _distance;
      _outStudent.image = imagePath;

      _positionStudent.latitude = position.latitude;
      _positionStudent.longitude = position.longitude;

      _outStudent.positionStudent = _positionStudent;
      _outStudent.time = DateTime.now();

      return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return CustomDialogBox(
            children: [
              SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Are you sure want to out the class?',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<StudentBloc>(context).add(
                      StudentDoOut(
                        outStudent: _outStudent,
                        roomId: widget.roomId,
                        studentId: widget.student.studentId,
                        time: widget.time,
                      ),
                    );
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

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
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 3),
                    Material(
                      color: transparentColor,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        onTap: () {
                          _captureImage();
                          _pc1.open();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/images/ic_shutter_1.png',
                            width: 72.0,
                            height: 72.0,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: transparentColor,
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
                          width: MediaQuery.of(context).size.width / 3,
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
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              minHeight: 0,
              maxHeight: MediaQuery.of(context).size.height * 0.95,
              controller: _pc1,
              color: transparentColor,
              defaultPanelState: PanelState.CLOSED,
              panel: Scaffold(
                backgroundColor: transparentColor,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: imagePath == null || position == null
                            ? WidgetLoadingIndicator(color: primaryColor)
                            : Column(
                                children: [
                                  Container(
                                    height: 350,
                                    child: Image.file(
                                      File(imagePath),
                                    ),
                                  ),
                                  Text(
                                    widget.roomId == null ? '' : widget.roomId,
                                    style: TextStyle(fontSize: 16, color: textColor),
                                  ),
                                  Text(
                                    widget.student.studentName == null ? '' : widget.student.studentName,
                                    style: TextStyle(fontSize: 16, color: textColor),
                                  ),
                                  Text(
                                    'Location ' + position.latitude.toString() + ', ' + position.longitude.toString(),
                                    style: TextStyle(fontSize: 16, color: textColor),
                                  ),
                                  Text(
                                    'Distance ' + _distance.toStringAsFixed(2) + ' meters',
                                    style: TextStyle(fontSize: 16, color: textColor),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RaisedButton(
                                        color: greenColor,
                                        child: Text('Attend', style: TextStyle(color: textColor)),
                                        onPressed: () {
                                          _handleAttendButton(parentContext: context);
                                        },
                                      ),
                                      RaisedButton(
                                        color: redColor,
                                        child: Text('Out', style: TextStyle(color: textColor)),
                                        onPressed: () {
                                          _handleOutButton(parentContext: context);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              onPanelOpened: () {
                _getCurrentPosition();
              },
            ),
          ],
        ),
      ),
    );
  }
}
