import 'dart:ui';

import 'package:attendance/ui/view/Student/HomeView/widgets/class-page-content.dart';
import 'package:attendance/ui/view/Student/HomeView/widgets/home-page-content.dart';
import 'package:attendance/ui/view/Student/HomeView/widgets/profile-page-content.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class HomeView extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomeView({this.cameras});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController _controller;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          _buildWidgetMainHomePage(buildContext),
        ],
      ),
    );
  }

  Widget _buildWidgetMainHomePage(BuildContext buildContext) {
    return Stack(
      children: <Widget>[
        PageView(
          controller: _controller,
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            ClassPageContent(),
            HomePageContent(widget.cameras),
            ProfilePageContent(),
          ],
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
        ),
        _buildWidgetMainMenuHomePage(buildContext),
      ],
    );
  }

  Widget _buildWidgetMainMenuHomePage(BuildContext buildContext) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(buildContext).size.height / 18.5,
        left: 10,
        right: 10,
      ),
      alignment: Alignment.topCenter,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.only(
              top: 7.0,
              bottom: 7.0,
              left: 7.0,
              right: MediaQuery.of(context).size.width / 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: currentPage == 0 ? Colors.indigo[900] : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 0;
                  _controller.jumpToPage(0);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.event_note_rounded,
                    color: currentPage == 0 ? Colors.white : Colors.indigo[700],
                    size: 22.0,
                  ),
                  Text(
                    'Class',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentPage == 0 ? Colors.white : Colors.indigo[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: currentPage == 1 ? Colors.indigo[900] : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 1;
                  _controller.jumpToPage(1);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: currentPage == 1 ? Colors.white : Colors.indigo[700],
                    size: 22.0,
                  ),
                  Text(
                    'Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentPage == 1 ? Colors.white : Colors.indigo[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.only(
              top: 7.0,
              bottom: 7.0,
              left: MediaQuery.of(context).size.width / 10,
              right: 7.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: currentPage == 2 ? Colors.indigo[900] : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 2;
                  _controller.jumpToPage(2);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.person,
                    color: currentPage == 2 ? Colors.white : Colors.indigo[700],
                    size: 22.0,
                  ),
                  Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentPage == 2 ? Colors.white : Colors.indigo[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
