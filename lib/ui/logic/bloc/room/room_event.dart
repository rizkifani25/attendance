part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class GetInfoRoomHistory extends RoomEvent {
  final String studentId;
  final String lecturerEmail;
  final String date;

  GetInfoRoomHistory({this.studentId, this.lecturerEmail, this.date});

  @override
  List<Object> get props => [studentId, lecturerEmail, date];
}

class UpdateRoomData extends RoomEvent {
  final String time;
  final String roomName;
  final String date;
  final Time updatedTime;

  UpdateRoomData({this.time, this.roomName, this.date, this.updatedTime});

  @override
  List<Object> get props => [time, roomName, date, updatedTime];
}
