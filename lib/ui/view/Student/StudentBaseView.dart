import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/view.dart';
import 'package:camera/new/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentBaseView extends StatelessWidget {
  final List<CameraDescription> cameras;
  StudentBaseView({this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-main2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<AuthStudentBloc, AuthStudentState>(
          builder: (context, state) {
            if (state is AuthStudentNotAuthenticated) {
              return StudentLoginView();
            }
            if (state is AuthStudentAuthenticated) {
              return HomeView();
            }
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}
