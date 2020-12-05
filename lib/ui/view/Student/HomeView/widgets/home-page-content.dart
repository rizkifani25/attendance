import 'dart:math';

import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/ui/logic/bloc/auth/student/auth_student_bloc.dart';
import 'package:attendance/ui/view/Student/HomeView/widgets/calendar.dart';
import 'package:attendance/ui/view/Student/HomeView/widgets/card-content.dart';
import 'package:intl/intl.dart';
import 'package:attendance/models/cards.dart';
import 'package:attendance/models/pages.dart';
import 'package:attendance/ui/logic/bloc/student/student_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePageContent extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePageContent(this.cameras);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  DataPages dataPages;
  List<DataCards> listDataCard = [];
  bool isPanelClosed = true;
  String _dateNow;
  String _dateTemp;
  String _studentId;

  @override
  void initState() {
    _dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    _dateTemp = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    super.initState();
  }

  _handleUpdateData() {
    BlocProvider.of<StudentBloc>(context).add(
      GetRoomHistory(
        studentId: _studentId,
        date: _dateTemp,
      ),
    );
  }

  _showCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Calendar(
            onSelectedDate: (date) {
              setState(() {
                _dateTemp = date;
              });
              _handleUpdateData();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthStudentBloc, AuthStudentState>(builder: (context, state) {
      if (state is AuthStudentAuthenticated) {
        return SlidingUpPanel(
          defaultPanelState: PanelState.CLOSED,
          minHeight: MediaQuery.of(context).size.height / 2.2,
          maxHeight: MediaQuery.of(context).size.height / 1.17,
          margin: EdgeInsets.only(
            left: 1.5,
            right: 1.5,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26.0),
            topRight: Radius.circular(26.0),
          ),
          body: Container(
            color: transparentColor,
          ),
          onPanelClosed: () {
            setState(() {
              _studentId = state.student.studentId;
              isPanelClosed = true;
            });
            _handleUpdateData();
          },
          onPanelOpened: () {
            setState(() {
              _studentId = state.student.studentId;
              isPanelClosed = false;
            });
            _handleUpdateData();
          },
          onPanelSlide: (position) {
            setState(() {
              _studentId = state.student.studentId;
            });
            _handleUpdateData();
          },
          panel: Stack(
            alignment: Alignment.topCenter,
            children: [
              Divider(
                thickness: 4.5,
                color: Colors.grey[400],
                indent: MediaQuery.of(context).size.width / 2 - 16.5,
                endIndent: MediaQuery.of(context).size.width / 2 - 16.5,
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  isPanelClosed ? 'Welcome!!!' : (_dateNow == _dateTemp ? 'Today\'s' : _dateTemp) + ' Class',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.indigo[700],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              isPanelClosed ? _buildIsPanelClosedTrue(context, state.student) : _buildIsPanelClosedFalse(context, state.student.studentId),
            ],
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    });
  }

  Widget _buildIsPanelClosedFalse(BuildContext context, String studentId) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        print(state);
        if (state is StudentLoadHistory) {
          return Scaffold(
            backgroundColor: transparentColor,
            floatingActionButton: !isPanelClosed
                ? FloatingActionButton(
                    backgroundColor: primaryColor,
                    child: Icon(Icons.date_range_rounded),
                    elevation: 5,
                    onPressed: () => _showCalendar(context),
                  )
                : Container(),
            body: Container(
              margin: EdgeInsets.only(top: 50),
              child: ListView.builder(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return Column(
                    children: state.roomHistory.map(
                      (e) {
                        return CardContent(
                          cameras: this.widget.cameras,
                          roomDetailResponse: e,
                          studentId: studentId,
                        );
                      },
                    ).toList(),
                  );
                },
                itemCount: 1,
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      },
    );
  }

  Widget _buildIsPanelClosedTrue(BuildContext context, Student studentDetail) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.only(
                top: 60.0,
                left: 15.0,
                right: 5.0,
                bottom: 5.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                  left: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                  right: BorderSide(
                    color: Colors.grey[300],
                    width: 1.3,
                    style: BorderStyle.solid,
                  ),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name\t: " + studentDetail.studentName),
                  Text("ID\t: " + studentDetail.studentId),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 50.0,
                left: 5.0,
                right: 15.0,
                bottom: 5.0,
              ),
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('https://via.placeholder.com/140x100'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 110,
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Transform.rotate(
                  angle: 270 * pi / 180,
                  child: Icon(
                    Icons.double_arrow_rounded,
                    color: primaryColor,
                  ),
                ),
                Text('Swipe up to open schedule today'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
