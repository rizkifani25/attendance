import 'package:attendance/models/list_time.dart';

class RoomDetailResponse {
  String roomId;
  String roomName;
  String date;
  ListTime listTime;

  RoomDetailResponse({this.roomId, this.roomName, this.date, this.listTime});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['room_name'] = this.roomName;
    data['date'] = this.date;
    data['list_time'] = this.listTime;
    return data;
  }

  factory RoomDetailResponse.fromJson(Map<String, dynamic> json) {
    return RoomDetailResponse(
      roomId: json['room_id'],
      roomName: json['room_name'],
      date: json['date'],
      listTime: ListTime.fromJson(json['list_time']),
    );
  }
}
