import 'dart:async';

import 'package:attendance/data/repositories/lecturerRepository.dart';
import 'package:attendance/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_lecturer_event.dart';
part 'auth_lecturer_state.dart';

class AuthLecturerBloc extends Bloc<AuthLecturerEvent, AuthLecturerState> {
  final LecturerRepository lecturerRepository;

  AuthLecturerBloc({@required this.lecturerRepository}) : super(AuthLecturerInitial());

  @override
  Stream<AuthLecturerState> mapEventToState(
    AuthLecturerEvent event,
  ) async* {
    if (event is AppLoadedLecturer) {
      yield* _mapAppLoadedLecturerToState(event);
    }

    if (event is LecturerLoggedIn) {
      yield* _mapLecturerLoggedInToState(event);
    }

    if (event is LecturerLoggedOut) {
      yield* _mapLecturerLoggedOutToState(event);
    }
  }

  Stream<AuthLecturerState> _mapAppLoadedLecturerToState(AppLoadedLecturer event) async* {
    yield AuthLecturerLoading();
    try {
      final Lecturer currentLecturer = await lecturerRepository.getLecturerLoginInfo();
      if (currentLecturer != null) {
        yield AuthLecturerAuthenticated(lecturer: currentLecturer);
      } else {
        yield AuthLecturerNotAuthenticated();
      }
    } catch (e) {
      yield AuthLecturerFailure(message: e ?? 'An unknown error occurred when auth');
    }
  }

  Stream<AuthLecturerState> _mapLecturerLoggedInToState(LecturerLoggedIn event) async* {
    yield AuthLecturerAuthenticated(lecturer: event.lecturer);
  }

  Stream<AuthLecturerState> _mapLecturerLoggedOutToState(LecturerLoggedOut event) async* {}
}
