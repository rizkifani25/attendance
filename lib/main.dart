import 'package:attendance/pages/home/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(AttendanceApp());
}

void logError(String code, String description) {
  print(code + " :: " + description);
}

class AttendanceApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.blue[900],
        body: HomePage(
          title: "Attendance v0.1",
        ),
      ),
    );
  }
}
