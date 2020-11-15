import 'dart:async';

import 'package:attendance/data/repositories/attendanceRepository.dart';
import 'package:attendance/ui/logic/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AttendanceRepository attendanceRepository;
  final AuthBloc authBloc;

  LoginBloc({this.attendanceRepository, this.authBloc}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginStudentWithStudentId) {
      yield* _mapLoginStudentWithStudentIdToState(event);
    }
  }

  Stream<LoginState> _mapLoginStudentWithStudentIdToState(LoginStudentWithStudentId event) async* {
    yield LoginLoading();

    try {
      final student = await attendanceRepository.getLoginInfo(event.studentId, event.password);
      if (student != null) {
        authBloc.add(UserLoggedIn(student: student));
        yield LoginSuccess();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } catch (e) {
      yield LoginFailure(error: 'An unknown error occurred when login');
    }
  }
}
