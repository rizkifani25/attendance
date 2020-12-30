import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Student/Widgets/student_attend_page.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/font.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetStudentCardDetailClass extends StatelessWidget {
  final List<CameraDescription> cameras;
  final RoomDetail roomDetail;
  final Time time;
  final Student student;
  final _studentPermissionController = TextEditingController();

  WidgetStudentCardDetailClass({this.cameras, this.roomDetail, this.time, this.student});

  Permission _getStudentPermission() {
    Permission permission;
    for (var i = 0; i < time.enrolled.length; i++) {
      if (time.enrolled[i].student.studentId == student.studentId) {
        permission = time.enrolled[i].permission;
      }
    }
    return permission;
  }

  _handleSendPermission({BuildContext parentContext}) async {
    if (_studentPermissionController.text != '') {
      Permission permission = new Permission();
      permission.statusPermission = '';
      permission.reason = _studentPermissionController.text;
      permission.datePermission = DateTime.now();

      BlocProvider.of<StudentBloc>(parentContext).add(
        StudentDoPermission(
          permission: permission,
          roomId: roomDetail.roomId,
          studentId: student.studentId,
          time: time.time,
        ),
      );
    } else {
      Permission permission = new Permission();
      permission.reason = '';
      permission.statusPermission = '';
      permission.datePermission = DateTime.now();

      BlocProvider.of<StudentBloc>(parentContext).add(
        StudentDoPermission(
          permission: permission,
          roomId: roomDetail.roomId,
          studentId: student.studentId,
          time: time.time,
        ),
      );
    }
  }

  _handlePermissionButton({BuildContext parentContext}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Permission',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                controller: _studentPermissionController,
                keyboardType: TextInputType.text,
                autocorrect: false,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(10),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _handleSendPermission(parentContext: context);
                    WidgetNotificationSnackbar().render(
                      context: parentContext,
                      message: 'Permission sent',
                    );
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Permission studentPermission = _getStudentPermission();

    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5.5,
          color: primaryColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: WidgetFont(text: time.time, color: secondaryColor),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: WidgetFont(text: time.subject, color: secondaryColor, fontSize: 16),
              ),
              Container(
                alignment: Alignment.center,
                child: WidgetFont(text: time.status.statusMessage, color: secondaryColor, fontSize: 14),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: WidgetFont(text: time.lecturer.lecturerName, color: secondaryColor, fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: WidgetFont(text: 'Permission : ' + studentPermission.reason, color: secondaryColor, fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: time.status.statusMessage == 'Dismissed' ? greyColor3 : greenColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: WidgetFont(
                        text: 'Attend',
                        color: time.status.statusMessage == 'Dismissed' ? blackColor : secondaryColor,
                        fontSize: 16,
                      ),
                      onPressed: time.status.statusMessage == 'Dismissed'
                          ? () {
                              WidgetNotificationSnackbar().render(
                                context: context,
                                color: redColor,
                                message: 'Class already dismiss',
                              );
                            }
                          : () {
                              DateTime dateNow = DateTime.now();
                              if ((dateNow.isBefore(time.punchIn) || dateNow.isAfter(time.punchOut))) {
                                WidgetNotificationSnackbar().render(
                                  context: context,
                                  color: redColor,
                                  message: 'You can only attend at the scheduled time or when Lecturer already start the session.',
                                );
                              } else if (dateNow.isAfter(time.punchIn) && dateNow.isBefore(time.punchOut) && time.status.statusMessage == 'On going') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return StudentAttendPage(
                                        cameras: cameras,
                                        student: student,
                                        roomId: roomDetail.roomId,
                                        time: time.time,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                WidgetNotificationSnackbar().render(
                                  context: context,
                                  color: redColor,
                                  message: 'Class not yet started or already dismissed',
                                );
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return StudentAttendPage(
                              //         cameras: cameras,
                              //         student: student,
                              //         roomId: roomDetail.roomId,
                              //         time: time.time,
                              //       );
                              //     },
                              //   ),
                              // );
                            },
                    ),
                    RaisedButton(
                      color: time.status.statusMessage == 'Dismissed' ? greyColor3 : yellowColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: WidgetFont(
                        text: 'Permission',
                        color: time.status.statusMessage == 'Dismissed' ? blackColor : secondaryColor,
                        fontSize: 16,
                      ),
                      onPressed: time.status.statusMessage == 'Dismissed'
                          ? () {
                              WidgetNotificationSnackbar().render(
                                context: context,
                                color: redColor,
                                message: 'Class already dismiss',
                              );
                            }
                          : () {
                              _handlePermissionButton(parentContext: context);
                            },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      onTap: () {
        print('ON TAP');
      },
    );
  }
}
