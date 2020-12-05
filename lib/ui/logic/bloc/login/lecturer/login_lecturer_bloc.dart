import 'dart:async';
import 'dart:convert';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/bloc/bloc.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_lecturer_event.dart';
part 'login_lecturer_state.dart';

class LoginLecturerBloc extends Bloc<LoginLecturerEvent, LoginLecturerState> {
  final LecturerRepository lecturerRepository;
  final AuthLecturerBloc authLecturerBloc;

  LoginLecturerBloc({this.lecturerRepository, this.authLecturerBloc}) : super(LoginLecturerInitial());

  @override
  Stream<LoginLecturerState> mapEventToState(
    LoginLecturerEvent event,
  ) async* {
    if (event is LoginLecturerWithLecturerEmail) {
      yield* _mapLoginLecturerWithLecturerEmailToState(event);
    }
  }

  Stream<LoginLecturerState> _mapLoginLecturerWithLecturerEmailToState(LoginLecturerWithLecturerEmail event) async* {
    yield LoginLecturerLoading();

    try {
      BasicResponse basicResponse = await lecturerRepository.signInLecturer(event.lecturerEmail, event.password);
      if (basicResponse.responseCode == 200) {
        Lecturer lecturer = Lecturer.fromJson(jsonDecode(jsonEncode(basicResponse.data)));
        SessionManagerService().setLecturer(lecturer);
        authLecturerBloc.add(LecturerLoggedIn(lecturer: lecturer));
        yield LoginLecturerSuccess();
      } else {
        yield LoginLecturerFailure(message: 'Something very weird just happened');
      }
    } catch (e) {
      yield LoginLecturerFailure(message: 'An unknown error occurred when login');
    }
  }
}
