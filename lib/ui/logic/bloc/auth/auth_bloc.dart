import 'dart:async';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LecturerRepository lecturerRepository;
  final StudentRepository studentRepository;

  AuthBloc({this.lecturerRepository, this.studentRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // Lecturer
    if (event is AppLoadedLecturer) {
      yield* _mapAppLoadedLecturerToState(event);
    }

    if (event is LecturerLoggedIn) {
      yield* _mapLecturerLoggedInToState(event);
    }

    if (event is LecturerLoggedOut) {
      yield* _mapLecturerLoggedOutToState(event);
    }

    // Student
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

  // Lecturer
  Stream<AuthState> _mapAppLoadedLecturerToState(AppLoadedLecturer event) async* {
    yield AuthLoading();
    try {
      final Lecturer currentLecturer = await lecturerRepository.getLecturerLoginInfo();
      if (currentLecturer != null) {
        yield AuthLecturerAuthenticated(lecturer: currentLecturer);
      } else {
        yield AuthLecturerNotAuthenticated();
      }
    } catch (e) {
      yield AuthFailure(message: e ?? 'An unknown error occurred when auth');
    }
  }

  Stream<AuthState> _mapLecturerLoggedInToState(LecturerLoggedIn event) async* {
    yield AuthLecturerAuthenticated(lecturer: event.lecturer);
  }

  Stream<AuthState> _mapLecturerLoggedOutToState(LecturerLoggedOut event) async* {
    await lecturerRepository.signOutLecturer();
    yield AuthLecturerNotAuthenticated();
  }

  // Student
  Stream<AuthState> _mapAppLoadedStudentToState(AppLoadedStudent event) async* {
    yield AuthLoading();
    try {
      final Student currenStudent = await studentRepository.getStudentLoginInfo();
      if (currenStudent != null) {
        yield AuthStudentAuthenticated(student: currenStudent);
      } else {
        yield AuthStudentNotAuthenticated();
      }
    } catch (e) {
      yield AuthFailure(message: e ?? 'An unknown error occurred when auth');
    }
  }

  Stream<AuthState> _mapStudentLoggedInToState(StudentLoggedIn event) async* {
    yield AuthStudentAuthenticated(student: event.student);
  }

  Stream<AuthState> _mapStudentLoggedOutToState(StudentLoggedOut event) async* {
    await studentRepository.signOutStudent();
    yield AuthStudentNotAuthenticated();
  }
}
