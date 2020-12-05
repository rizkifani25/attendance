import 'dart:async';
import 'dart:convert';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_student_event.dart';
part 'login_student_state.dart';

class LoginStudentBloc extends Bloc<LoginStudentEvent, LoginStudentState> {
  final StudentRepository studentRepository;
  final AuthStudentBloc authStudentBloc;

  LoginStudentBloc({this.studentRepository, this.authStudentBloc}) : super(LoginStudentInitial());

  @override
  Stream<LoginStudentState> mapEventToState(
    LoginStudentEvent event,
  ) async* {
    if (event is LoginStudentWithStudentId) {
      yield* _mapLoginStudentWithStudentIdToState(event);
    }
  }

  Stream<LoginStudentState> _mapLoginStudentWithStudentIdToState(LoginStudentWithStudentId event) async* {
    yield LoginStudentLoading();

    try {
      BasicResponse basicResponse = await studentRepository.signInStudent(event.studentId, event.password);
      if (basicResponse.responseCode == 200) {
        Student student = Student.fromJson(jsonDecode(jsonEncode(basicResponse.data)));
        SessionManagerService().setStudent(student);
        authStudentBloc.add(StudentLoggedIn(student: student));
        yield LoginStudentSuccess();
      } else {
        yield LoginStudentFailure(message: basicResponse.responseMessage);
      }
    } catch (e) {
      print(e);
      yield LoginStudentFailure(message: 'An unknown error occurred when login');
    }
  }
}
