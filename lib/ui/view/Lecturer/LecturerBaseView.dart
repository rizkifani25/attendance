import 'package:attendance/constant/Constant.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/BaseView/base_view.dart';
import 'package:attendance/ui/view/Lecturer/Widgets/card_info_lecturer.dart';
import 'package:attendance/ui/view/Lecturer/Widgets/divider.dart';
import 'package:attendance/ui/view/Widgets/font.dart';
import 'package:attendance/ui/view/Widgets/history_room.dart';
import 'package:attendance/ui/view/Widgets/log_out_button.dart';
import 'package:attendance/ui/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturerBaseView extends StatefulWidget {
  @override
  _LecturerBaseViewState createState() => _LecturerBaseViewState();
}

class _LecturerBaseViewState extends State<LecturerBaseView> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AppLoadedLecturer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLecturerNotAuthenticated) {
            return LecturerLoginView();
          }
          if (state is AuthLecturerAuthenticated) {
            return BaseView(
              classPageContentList: [
                WidgetDivider(),
                Center(
                  child: WidgetFont(text: 'History Class', color: primaryColor, weight: FontWeight.bold),
                ),
              ],
              homePageContentList: [
                WidgetDivider(),
                WidgetCardInfoLecturer(),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: WidgetFont(text: 'Today\'s Class', color: primaryColor, weight: FontWeight.bold, fontSize: 20),
                ),
                WidgetHistoryRoom(),
              ],
              profilePageContentList: [
                WidgetDivider(),
                Center(
                  child: WidgetFont(text: 'Profile', color: primaryColor, weight: FontWeight.bold),
                ),
                WidgetLogOutButton(
                  handleSignOutButton: () => BlocProvider.of<AuthBloc>(context).add(LecturerLoggedOut()),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }
}
