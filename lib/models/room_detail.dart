import 'package:attendance/models/models.dart';

class RoomDetail {
  String roomId;
  String roomName;
  String date;
  ListTime listTime;

  RoomDetail({this.roomId, this.roomName, this.date, this.listTime});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['room_name'] = this.roomName;
    data['date'] = this.date;
    data['list_time'] = this.listTime;
    return data;
  }

  factory RoomDetail.fromJson(Map<String, dynamic> json) {
    return RoomDetail(
      roomId: json['room_id'],
      roomName: json['room_name'],
      date: json['date'],
      listTime: ListTime.fromJson(json['list_time']),
    );
  }
}
