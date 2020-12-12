import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Student/Widgets/student_attend_page.dart';
import 'package:attendance/ui/view/Widgets/font.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WidgetStudentCardDetailClass extends StatelessWidget {
  final List<CameraDescription> cameras;
  final RoomDetailResponse roomDetail;
  final Time time;
  final Student student;

  WidgetStudentCardDetailClass({this.cameras, this.roomDetail, this.time, this.student});

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
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: WidgetFont(text: time.lecturer.lecturerName, color: secondaryColor, fontSize: 14),
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
                                  message: 'You can only attend at the scheduled time',
                                );
                              } else if (dateNow.isAfter(time.punchIn) && dateNow.isBefore(time.punchOut)) {
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
                                  message: time.status.statusMessage,
                                );
                              }
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
                                message: 'Class already dismiss',
                              );
                            }
                          : () {
                              WidgetNotificationSnackbar().render(
                                context: context,
                                message: 'Permission sent',
                              );
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
