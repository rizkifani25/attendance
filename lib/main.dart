import 'package:attendance/data/dataproviders/attendanceAPI.dart';
import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/ui/logic/bloc/auth/auth_bloc.dart';
import 'package:attendance/ui/logic/bloc/login/login_bloc.dart';
import 'package:attendance/ui/logic/bloc/student/student_bloc.dart';
import 'package:attendance/ui/view/HomeView/home.dart';
import 'package:attendance/ui/view/LoginView/login_view.dart';
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
  final attendanceRepository = AttendanceRepository(
    attendanceApi: AttendanceApi(),
  );
  runApp(
    RepositoryProvider.value(
      value: attendanceRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              attendanceRepository: attendanceRepository,
            )..add(
                AppLoaded(),
              ),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              attendanceRepository: attendanceRepository,
              authBloc: BlocProvider.of<AuthBloc>(context),
            ),
          ),
          BlocProvider<StudentBloc>(
            create: (context) => StudentBloc(attendanceRepository: attendanceRepository),
          ),
        ],
        child: AttendanceApp(
            // appRouter: AppRouter(),
            ),
      ),
    ),
  );
}

void logError(String code, String description) {
  print(code + " :: " + description);
}

class AttendanceApp extends StatelessWidget {
  // This widget is the root of your application.
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
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {},
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return HomeView(cameras);
                }
                if (state is AuthNotAuthenticated) {
                  return LoginView();
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
      ),
    );
  }
}
