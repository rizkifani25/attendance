import 'package:attendance/data/dataproviders/dataproviders.dart';
import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PageBloc>(
            create: (context) => PageBloc()
              ..add(
                RenderSelectedPage(pageState: 'loginStudent'),
              ),
          ),
          BlocProvider<AuthLecturerBloc>(
            create: (context) => AuthLecturerBloc(
              lecturerRepository: LecturerRepository(attendanceApi: AttendanceApi()),
            ),
          ),
          BlocProvider<LoginLecturerBloc>(
            create: (context) => LoginLecturerBloc(
              lecturerRepository: LecturerRepository(attendanceApi: AttendanceApi()),
              authLecturerBloc: BlocProvider.of<AuthLecturerBloc>(context),
            ),
          ),
          BlocProvider<AuthStudentBloc>(
            create: (context) => AuthStudentBloc(
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
            ),
          ),
          BlocProvider<LoginStudentBloc>(
            create: (context) => LoginStudentBloc(
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
              authStudentBloc: BlocProvider.of<AuthStudentBloc>(context),
            ),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc(
              studentRepository: StudentRepository(attendanceApi: AttendanceApi()),
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
                BlocProvider.of<AuthLecturerBloc>(context).add(AppLoadedLecturer());
                return LecturerLoginView();
              }
              if (state is StudentLoginViewState) {
                BlocProvider.of<AuthStudentBloc>(context).add(AppLoadedStudent());
                return StudentBaseView();
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
