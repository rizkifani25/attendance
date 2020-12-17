import 'dart:async';

import 'package:attendance/data/repositories/repositories.dart';
import 'package:attendance/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomRepository roomRepository;
  RoomBloc({@required this.roomRepository}) : super(RoomInitial());

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is GetInfoRoomHistory) {
      yield* _mapGetInfoRoomHistoryToState(event);
    }
    if (event is UpdateRoomData) {
      yield* _mapUpdateRoomData(event);
    }
  }

  Stream<RoomState> _mapGetInfoRoomHistoryToState(GetInfoRoomHistory event) async* {
    yield RoomFetchLoading();
    try {
      final BasicResponse _findRoomResult = await roomRepository.getInfoRoomHistory(studentId: event.studentId, lecturerEmail: event.lecturerEmail, date: event.date);

      if (_findRoomResult.responseCode != 200) {
        yield RoomFetchingFailure(message: _findRoomResult.responseMessage);
      } else {
        var tagObjsJson = _findRoomResult.data as List;
        List<RoomDetail> roomDetail = tagObjsJson.map((e) => RoomDetail.fromJson(e)).toList();
        yield GetRoomHistorySuccess(roomDetail: roomDetail);
      }
    } catch (e) {
      print(e.toString());
      yield RoomFetchingFailure(message: 'Something weird happen when fetching room history');
    }
  }

  Stream<RoomState> _mapUpdateRoomData(UpdateRoomData event) async* {
    yield RoomFetchLoading();

    try {
      final roomUpdate = await roomRepository.updateRoomData(event.time, event.roomName, event.date, event.updatedTime);

      if (roomUpdate.responseCode == 200) {
        yield RoomFetchingSuccess(message: 'Data updated');
      } else {
        yield RoomFetchingFailure(message: 'Something very weird just happened');
      }
    } catch (e) {
      yield RoomFetchingFailure(message: 'An unknown error occurred when update data');
    }
  }
}
