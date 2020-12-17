import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Student/Widgets/student_attend_page.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/font.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WidgetStudentCardDetailClass extends StatelessWidget {
  final List<CameraDescription> cameras;
  final RoomDetail roomDetail;
  final Time time;
  final Student student;

  WidgetStudentCardDetailClass({this.cameras, this.roomDetail, this.time, this.student});

  _handlePermissionButton({BuildContext parentContext}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              child: Text(
                'PERMISSION',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                alignment: Alignment.center,
                child: WidgetFont(text: time.lecturer.lecturerName, color: secondaryColor, fontSize: 16),
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
                              // if ((dateNow.isBefore(time.punchIn) || dateNow.isAfter(time.punchOut))) {
                              //   WidgetNotificationSnackbar().render(
                              //     context: context,
                              //     color: redColor,
                              //     message: 'You can only attend at the scheduled time or when Lecturer already start the session.',
                              //   );
                              // } else if (dateNow.isAfter(time.punchIn) && dateNow.isBefore(time.punchOut) || time.status.statusMessage == 'On going') {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) {
                              //         return StudentAttendPage(
                              //           cameras: cameras,
                              //           student: student,
                              //           roomId: roomDetail.roomId,
                              //           time: time.time,
                              //         );
                              //       },
                              //     ),
                              //   );
                              // } else {
                              //   WidgetNotificationSnackbar().render(
                              //     context: context,
                              //     color: redColor,
                              //     message: 'Class already dismissed',
                              //   );
                              // }
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
