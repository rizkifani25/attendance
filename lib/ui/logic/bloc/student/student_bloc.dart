import 'dart:async';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc({this.studentRepository}) : super(StudentInitial());

  @override
  Stream<StudentState> mapEventToState(
    StudentEvent event,
  ) async* {
    if (event is StudentDoPermission) {
      yield* _mapStudentDoPermissionToState(event);
    }
    if (event is StudentDoAttend) {
      yield* _mapStudentDoAttendToState(event);
    }
    if (event is StudentDoOut) {
      yield* _mapStudentDoOutToState(event);
    }
  }

  Stream<StudentState> _mapStudentDoPermissionToState(StudentDoPermission event) async* {
    yield StudentFetchLoading();
    try {
      final BasicResponse basicResponse = await studentRepository.studentDoPermission(
        event.permission,
        event.roomId,
        event.studentId,
        event.time,
      );

      if (basicResponse != null) {
        yield StudentFetchSuccess();
      } else {
        yield StudentFetchFailed(message: 'Failed when fetching');
      }
    } catch (e) {
      print(e.toString());
      yield StudentFetchFailed(message: 'Something very weird just happened');
    }
  }

  Stream<StudentState> _mapStudentDoAttendToState(StudentDoAttend event) async* {
    yield StudentFetchLoading();
    try {
      final BasicResponse basicResponse = await studentRepository.studentDoAttend(
        event.attendStudent,
        event.roomId,
        event.studentId,
        event.time,
      );

      if (basicResponse != null) {
        yield StudentFetchSuccess();
      } else {
        yield StudentFetchFailed(message: 'Failed when fetching');
      }
    } catch (e) {
      print(e.toString());
      yield StudentFetchFailed(message: 'Something very weird just happened');
    }
  }

  Stream<StudentState> _mapStudentDoOutToState(StudentDoOut event) async* {
    yield StudentFetchLoading();
    try {
      final BasicResponse basicResponse = await studentRepository.studentDoOut(
        event.outStudent,
        event.roomId,
        event.studentId,
        event.time,
      );

      if (basicResponse != null) {
        yield StudentFetchSuccess();
      } else {
        yield StudentFetchFailed(message: 'Failed when fetching');
      }
    } catch (e) {
      print(e.toString());
      yield StudentFetchFailed(message: 'Something very weird just happened');
    }
  }
}
