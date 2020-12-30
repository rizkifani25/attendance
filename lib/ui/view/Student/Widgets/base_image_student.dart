import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:attendance/ui/view/Student/Widgets/base_image_capture.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseImageStudent extends StatefulWidget {
  final List<CameraDescription> cameras;

  BaseImageStudent({this.cameras});

  @override
  _BaseImageStudentState createState() => _BaseImageStudentState();
}

class _BaseImageStudentState extends State<BaseImageStudent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStudentAuthenticated) {
          if (state.student.baseImagePath == '') {
            return Column(
              children: [
                Center(
                  child: Text(
                    'Base image does\'nt exist',
                    style: TextStyle(
                      color: greyColor3,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: greenColor,
                  child: Text('Take Picture', style: TextStyle(color: textColor)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BaseImageCapture(cameras: widget.cameras, student: state.student);
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FutureBuilder(
                      future: _getImage(context, state.student.baseImagePath),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done)
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: snapshot.data,
                          );

                        if (snapshot.connectionState == ConnectionState.waiting) return Container(height: MediaQuery.of(context).size.height / 1.25, width: MediaQuery.of(context).size.width / 1.25, child: CircularProgressIndicator());

                        return Container();
                      },
                    ),
                  ),
                ),
                RaisedButton(
                  color: greenColor,
                  child: Text('Update', style: TextStyle(color: textColor)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BaseImageCapture(cameras: widget.cameras, student: state.student);
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }
        return WidgetLoadingIndicator(color: primaryColor);
      },
    );
  }

  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
    await FireBaseStorageService.loadImage(context, image).then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m;
  }
}
