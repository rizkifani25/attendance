import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Widgets/font.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WidgetStudentCardDetailClass extends StatelessWidget {
  final RoomDetailResponse roomDetail;
  final Time time;

  WidgetStudentCardDetailClass({this.roomDetail, this.time});

  _handleUpdateData({BuildContext context, String statusMessage}) {
    Time updatedTime = new Time(
      time: time.time,
      status: new RoomStatus(status: true, statusMessage: statusMessage),
      enrolled: time.enrolled,
      lecturer: time.lecturer,
      subject: time.subject,
    );
    BlocProvider.of<RoomBloc>(context).add(
      UpdateRoomData(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        time: time.time == '07.30 - 09.30'
            ? 'time1'
            : time.time == '10.00 - 12.00'
                ? 'time2'
                : time.time == '12.30 - 14.30'
                    ? 'time3'
                    : 'time4',
        roomName: roomDetail.roomName,
        updatedTime: updatedTime,
      ),
    );
    BlocProvider.of<RoomBloc>(context).add(
      GetInfoRoomHistory(
        studentId: '',
        lecturerEmail: time.lecturer.lecturerEmail,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      ),
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
                              if ((dateNow.isBefore(time.punchIn) || dateNow.isAfter(time.punchOut)) && time.status.statusMessage == 'Booked') {
                                WidgetNotificationSnackbar().render(
                                  context: context,
                                  color: redColor,
                                  message: 'You can only attend at the scheduled time',
                                );
                              } else if (dateNow.isAfter(time.punchIn) && dateNow.isBefore(time.punchOut) && time.status.statusMessage == 'Booked') {
                                print('attended');
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
