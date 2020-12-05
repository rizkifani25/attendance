import 'dart:async';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_student_event.dart';
part 'auth_student_state.dart';

class AuthStudentBloc extends Bloc<AuthStudentEvent, AuthStudentState> {
  final StudentRepository studentRepository;

  AuthStudentBloc({@required this.studentRepository}) : super(AuthStudentInitial());

  @override
  Stream<AuthStudentState> mapEventToState(
    AuthStudentEvent event,
  ) async* {
    if (event is AppLoadedStudent) {
      yield* _mapAppLoadedStudentToState(event);
    }

    if (event is StudentLoggedIn) {
      yield* _mapStudentLoggedInToState(event);
    }

    if (event is StudentLoggedOut) {
      yield* _mapStudentLoggedOutToState(event);
    }
  }

  Stream<AuthStudentState> _mapAppLoadedStudentToState(AppLoadedStudent event) async* {
    yield AuthStudentLoading();
    try {
      final Student currenStudent = await studentRepository.getStudentLoginInfo();
      if (currenStudent != null) {
        yield AuthStudentAuthenticated(student: currenStudent);
      } else {
        yield AuthStudentNotAuthenticated();
      }
    } catch (e) {
      yield AuthStudentAuthFailure(message: e ?? 'An unknown error occurred when auth');
    }
  }

  Stream<AuthStudentState> _mapStudentLoggedInToState(StudentLoggedIn event) async* {
    yield AuthStudentAuthenticated(student: event.student);
  }

  Stream<AuthStudentState> _mapStudentLoggedOutToState(StudentLoggedOut event) async* {
    await studentRepository.signOutStudent();
    yield AuthStudentNotAuthenticated();
  }
}
