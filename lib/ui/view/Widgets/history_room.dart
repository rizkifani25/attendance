import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/view/Student/Widgets/student_expandable_card_room.dart';
import 'package:attendance/ui/view/Widgets/calendar.dart';
import 'package:attendance/ui/view/Widgets/custom_dialog.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:attendance/ui/view/Widgets/notification_snackbar.dart';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Lecturer/Widgets/lecturer_expandable_card_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetHistoryRoom extends StatelessWidget {
  final List<CameraDescription> cameras;
  final bool fromHistoryPanel;

  WidgetHistoryRoom({this.cameras, this.fromHistoryPanel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLecturerAuthenticated) {
          if (state.lecturer.historyRoom.isEmpty) {
            return Center(
              child: Text(
                'History not found',
                style: TextStyle(
                  color: greyColor3,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return _RoomDetail(
              listRoom: state.lecturer.historyRoom,
              lecturer: state.lecturer,
              fromHistoryPanel: fromHistoryPanel,
            );
          }
        }
        if (state is AuthStudentAuthenticated) {
          if (state.student.historyRoom.isEmpty) {
            return Center(
              child: Text(
                'History not found',
                style: TextStyle(
                  color: greyColor3,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return _RoomDetail(
              cameras: cameras,
              listRoom: state.student.historyRoom,
              student: state.student,
              fromHistoryPanel: fromHistoryPanel,
            );
          }
        }
        return WidgetLoadingIndicator(color: primaryColor);
      },
    );
  }
}

class _RoomDetail extends StatefulWidget {
  final List<CameraDescription> cameras;
  final List<RoomHistory> listRoom;
  final Lecturer lecturer;
  final Student student;
  final bool fromHistoryPanel;

  _RoomDetail({this.cameras, this.listRoom, this.lecturer, this.student, this.fromHistoryPanel});

  @override
  __RoomDetailState createState() => __RoomDetailState();
}

class __RoomDetailState extends State<_RoomDetail> {
  String date;

  @override
  void initState() {
    if (widget.lecturer != null) {
      BlocProvider.of<RoomBloc>(context).add(
        GetInfoRoomHistory(
          studentId: '',
          lecturerEmail: widget.lecturer.lecturerEmail,
          date: widget.fromHistoryPanel ? '' : DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        ),
      );
    }
    if (widget.student != null) {
      BlocProvider.of<RoomBloc>(context).add(
        GetInfoRoomHistory(
          studentId: widget.student.studentId,
          lecturerEmail: '',
          date: widget.fromHistoryPanel ? '' : DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        ),
      );
    }

    super.initState();
  }

  _handleCalendarButton({BuildContext parentContext}) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return CustomDialogBox(
          children: [
            SizedBox(height: 50),
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Calendar(
                  onSelectedDate: (value) {
                    setState(() {
                      date = value;
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (widget.lecturer != null) {
        BlocProvider.of<RoomBloc>(context).add(
          GetInfoRoomHistory(
            studentId: '',
            lecturerEmail: widget.lecturer.lecturerEmail,
            date: date,
          ),
        );
      }
      if (widget.student != null) {
        BlocProvider.of<RoomBloc>(context).add(
          GetInfoRoomHistory(
            studentId: widget.student.studentId,
            lecturerEmail: '',
            date: date,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (widget.student != null || widget.lecturer != null) && widget.fromHistoryPanel
              ? IconButton(
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    color: primaryColor,
                  ),
                  onPressed: () => _handleCalendarButton(parentContext: context),
                )
              : Container(),
          BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              if (state is GetRoomHistorySuccess) {
                if (state.roomDetail.isEmpty) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        widget.fromHistoryPanel ? 'Empty' : 'Yeay! No class for today',
                        style: TextStyle(
                          color: greyColor2,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: state.roomDetail.map(
                      (e) {
                        if (widget.lecturer != null) {
                          return WidgetLecturerExpandableCardRoom(
                            roomDetail: e,
                            lecturer: widget.lecturer,
                            fromHistoryPanel: widget.fromHistoryPanel,
                          );
                        }
                        if (widget.student != null) {
                          return WidgetStudentExpandableCardRoom(
                            cameras: widget.cameras,
                            roomDetail: e,
                            student: widget.student,
                            fromHistoryPanel: widget.fromHistoryPanel,
                          );
                        }
                      },
                    ).toList(),
                  );
                }
              }
              if (state is RoomFetchingFailure) {
                WidgetNotificationSnackbar().render(
                  context: context,
                  color: redColor,
                  message: state.message,
                );
              }
              return WidgetLoadingIndicator(color: primaryColor);
            },
          ),
        ],
      ),
    );
  }
}
