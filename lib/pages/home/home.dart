import 'dart:ui';

import 'package:attendance/models/pages.dart';
import 'package:attendance/pages/home/widgets/class-page-content.dart';
import 'package:attendance/pages/home/widgets/home-page-content.dart';
import 'package:attendance/pages/home/widgets/profile-page-content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;
  DataPages dataPages;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1,
    );
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
            HomePageContent(),
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
    var mediaQuery = MediaQuery.of(buildContext);

    return Container(
      margin: EdgeInsets.only(
        top: mediaQuery.size.height / 11,
        left: 10,
        right: 10,
      ),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: currentPage == 0 ? Colors.indigo[900] : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 0;
                  _controller.jumpToPage(0);
                });
              },
              child: Text(
                'Class',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: currentPage == 1 ? Colors.indigo[900] : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 1;
                  _controller.jumpToPage(1);
                });
              },
              child: Text(
                'Events',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: currentPage == 2 ? Colors.indigo[900] : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 2;
                  _controller.jumpToPage(2);
                });
              },
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
