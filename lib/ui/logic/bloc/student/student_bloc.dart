import 'dart:async';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/attend_student.dart';
import 'package:attendance/models/response/basic_response.dart';
import 'package:attendance/models/out_student.dart';
import 'package:attendance/models/response/room_detail_response.dart';
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
    if (event is GetRoomHistory) {
      yield* _mapGetRoomHistoryToState(event);
    }
    if (event is StudentDoAttend) {
      yield* _mapStudentDoAttendToState(event);
    }
    if (event is StudentDoOut) {
      yield* _mapStudentDoOutToState(event);
    }
  }

  Stream<StudentState> _mapGetRoomHistoryToState(GetRoomHistory event) async* {
    yield StudentLoadingHistory();
    try {
      final List<RoomDetailResponse> _roomHistory = await studentRepository.getRoomHistory(event.studentId, event.date);

      if (_roomHistory != null) {
        yield StudentLoadHistory(roomHistory: _roomHistory);
      } else {
        yield StudentLoadHistoryFailed(message: 'Failed when load history');
      }
    } catch (e) {
      yield StudentLoadHistoryFailed(message: e.toString() ?? 'Something very weird just happened');
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
      yield StudentFetchFailed(message: e.toString() ?? 'Something very weird just happened');
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
      yield StudentFetchFailed(message: e.toString() ?? 'Something very weird just happened');
    }
  }
}
