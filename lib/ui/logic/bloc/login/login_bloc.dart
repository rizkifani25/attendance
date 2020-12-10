import 'dart:async';
import 'dart:convert';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;
  final LecturerRepository lecturerRepository;
  final StudentRepository studentRepository;

  LoginBloc({this.authBloc, this.lecturerRepository, this.studentRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginLecturerWithLecturerEmail) {
      yield* _mapLoginLecturerWithLecturerEmailToState(event);
    }
    if (event is LoginStudentWithStudentId) {
      yield* _mapLoginStudentWithStudentIdToState(event);
    }
  }

  Stream<LoginState> _mapLoginLecturerWithLecturerEmailToState(LoginLecturerWithLecturerEmail event) async* {
    yield LoginLoading();

    try {
      BasicResponse basicResponse = await lecturerRepository.signInLecturer(event.lecturerEmail, event.password);
      if (basicResponse.responseCode == 200) {
        Lecturer lecturer = Lecturer.fromJson(jsonDecode(jsonEncode(basicResponse.data)));
        SessionManagerService().setLecturer(lecturer);
        authBloc.add(LecturerLoggedIn(lecturer: lecturer));
        yield LoginSuccess();
      } else {
        yield LoginFailure(message: basicResponse.responseMessage);
      }
    } catch (e) {
      print(e);
      yield LoginFailure(message: 'An unknown error occurred when login');
    }
  }

  Stream<LoginState> _mapLoginStudentWithStudentIdToState(LoginStudentWithStudentId event) async* {
    yield LoginLoading();

    try {
      BasicResponse basicResponse = await studentRepository.signInStudent(event.studentId, event.password);
      if (basicResponse.responseCode == 200) {
        Student student = Student.fromJson(jsonDecode(jsonEncode(basicResponse.data)));
        SessionManagerService().setStudent(student);
        authBloc.add(StudentLoggedIn(student: student));
        yield LoginSuccess();
      } else {
        yield LoginFailure(message: basicResponse.responseMessage);
      }
    } catch (e) {
      print(e);
      yield LoginFailure(message: 'An unknown error occurred when login');
    }
  }
}
