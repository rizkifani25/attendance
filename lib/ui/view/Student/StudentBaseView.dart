import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/BaseView/base_view.dart';
import 'package:attendance/ui/view/Lecturer/Widgets/divider.dart';
import 'package:attendance/ui/view/Student/Widgets/card_info_student.dart';
import 'package:attendance/ui/view/Widgets/font.dart';
import 'package:attendance/ui/view/Widgets/history_room.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:attendance/ui/view/Widgets/log_out_button.dart';
import 'package:attendance/ui/view/view.dart';

class StudentBaseView extends StatefulWidget {
  final List<CameraDescription> cameras;

  StudentBaseView({@required this.cameras});

  @override
  _StudentBaseViewState createState() => _StudentBaseViewState();
}

class _StudentBaseViewState extends State<StudentBaseView> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AppLoadedStudent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStudentNotAuthenticated) {
            return StudentLoginView();
          }
          if (state is AuthStudentAuthenticated) {
            return BaseView(
              classPageContentList: [
                WidgetDivider(),
                Center(
                  child: WidgetFont(text: 'History Class', color: primaryColor, weight: FontWeight.bold),
                ),
              ],
              homePageContentList: [
                WidgetDivider(),
                WidgetCardInfoStudent(),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: WidgetFont(text: 'Today\'s Class', color: primaryColor, weight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: primaryColor,
                        ),
                        onPressed: () => BlocProvider.of<RoomBloc>(context).add(
                          GetInfoRoomHistory(
                            studentId: state.student.studentId,
                            lecturerEmail: '',
                            date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                WidgetHistoryRoom(cameras: widget.cameras),
              ],
              profilePageContentList: [
                WidgetDivider(),
                Center(
                  child: WidgetFont(text: 'Profile', color: primaryColor, weight: FontWeight.bold),
                ),
                WidgetLogOutButton(
                  handleSignOutButton: () => BlocProvider.of<AuthBloc>(context).add(StudentLoggedOut()),
                ),
              ],
            );
          }
          return WidgetLoadingIndicator(color: primaryColor);
        },
      ),
    );
  }
}
