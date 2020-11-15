import 'dart:async';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/room_detail_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final AttendanceRepository attendanceRepository;

  StudentBloc({this.attendanceRepository}) : super(StudentInitial());

  @override
  Stream<StudentState> mapEventToState(
    StudentEvent event,
  ) async* {
    if (event is GetRoomHistory) {
      yield* _mapGetRoomHistoryToState(event);
    }
  }

  Stream<StudentState> _mapGetRoomHistoryToState(GetRoomHistory event) async* {
    yield StudentLoadingHistory();
    try {
      final List<RoomDetailResponse> _roomHistory =
          await attendanceRepository.getRoomHistory(event.studentId, event.date);

      if (_roomHistory != null) {
        yield StudentLoadHistory(roomHistory: _roomHistory);
      } else {
        yield StudentLoadHistoryFailed(message: 'Failed when load history');
      }
    } catch (e) {
      yield StudentLoadHistoryFailed(message: e ?? 'Something very weird just happened');
    }
  }
}
