import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/view/Lecturer/LoginView/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturerBaseView extends StatelessWidget {
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
        child: BlocBuilder<AuthLecturerBloc, AuthLecturerState>(
          builder: (context, state) {
            if (state is AuthLecturerNotAuthenticated) {
              return LecturerLoginView();
            }
            if (state is AuthLecturerAuthenticated) {
              return Container(
                child: Center(
                  child: Text('Masuk lecturer'),
                ),
              );
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
