import 'dart:async';

import 'package:attendance/constant/Constant.dart';
import 'package:attendance/data/dataproviders/dataproviders.dart';
import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:attendance/ui/view/Widgets/loading_indicator.dart';
import 'package:attendance/ui/view/view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    // Request Permission
    await PermissionService().requestRequiredPermission(
      onPermissionDenied: () {
        print('Permission denied');
      },
    );
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LecturerRepository>(
          create: (context) => LecturerRepository(attendanceApi: AttendanceApi()),
        ),
        RepositoryProvider<StudentRepository>(
          create: (context) => StudentRepository(attendanceApi: AttendanceApi()),
        ),
        RepositoryProvider<RoomRepository>(
          create: (context) => RoomRepository(attendanceApi: AttendanceApi()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NetworkBloc>(
            create: (context) => NetworkBloc()
              ..add(
                ListenConnection(),
              ),
          ),
          BlocProvider<PageBloc>(
            create: (context) => PageBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              lecturerRepository: LecturerRepository(attendanceApi: AttendanceApi()),
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
            ),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              lecturerRepository: LecturerRepository(attendanceApi: AttendanceApi()),
              authBloc: BlocProvider.of<AuthBloc>(context),
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
            ),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc(
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
            ),
          ),
          BlocProvider<RoomBloc>(
            create: (context) => RoomBloc(
              roomRepository: RoomRepository(attendanceApi: AttendanceApi()),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Attendance App',
          theme: ThemeData(
            fontFamily: 'Raleway',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AttendanceApp(),
        ),
      ),
    ),
  );
}

void logError(String code, String description) {
  print(code + " :: " + description);
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  String _versionName = 'V1.0';
  String _mode;
  final splashDelay = 10;

  @override
  void initState() {
    _loadWidget();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.forward();
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadWidget() async {
    String lecturer = await SessionManagerService().getLecturer();
    lecturer != '' ? _mode = 'lecturer' : _mode = 'student';

    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
      if (_mode == 'lecturer') {
        BlocProvider.of<PageBloc>(context).add(RenderSelectedPage(pageState: 'loginLecturer'));
      }
      if (_mode == 'student') {
        BlocProvider.of<PageBloc>(context).add(RenderSelectedPage(pageState: 'loginStudent'));
      }
      return MainApp();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon/calendar.png',
                      height: 70,
                      width: 70,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Attendance App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_versionName),
                    Text('Muhammad Rizki Fani'),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-main3.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkSuccess) {
              return MainView();
            }
            if (state is NetworkFailure) {
              return OfflineView();
            }
            return WidgetLoadingIndicator(color: primaryColor);
          },
        ),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        if (state is LecturerLoginViewState) {
          return LecturerBaseView();
        }
        if (state is StudentLoginViewState) {
          return StudentBaseView(cameras: cameras);
        }
        return WidgetLoadingIndicator(color: primaryColor);
      },
    );
  }
}
