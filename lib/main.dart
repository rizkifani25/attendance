import 'package:attendance/constant/Constant.dart';
import 'package:attendance/data/dataproviders/dataproviders.dart';
import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/logic/bloc/login/login_bloc.dart';
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

    SessionManagerService().setLecturer(null);
    SessionManagerService().setStudent(null);
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
          BlocProvider<PageBloc>(
            create: (context) => PageBloc()
              ..add(
                RenderSelectedPage(pageState: 'loginStudent'),
              ),
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
        child: AttendanceApp(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg-main2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              if (state is LecturerLoginViewState) {
                return LecturerBaseView();
              }
              if (state is StudentLoginViewState) {
                return StudentBaseView(cameras: cameras);
              }
              return WidgetLoadingIndicator(color: primaryColor);
            },
          ),
        ),
      ),
    );
  }
}
