import 'package:attendance/models/models.dart';

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

  @override
  String toString() {
    return 'RoomDetailResponse(roomId: $roomId, roomName: $roomName, date: $date, listTime: $listTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomDetailResponse && o.roomId == roomId && o.roomName == roomName && o.date == date && o.listTime == listTime;
  }

  @override
  int get hashCode {
    return roomId.hashCode ^ roomName.hashCode ^ date.hashCode ^ listTime.hashCode;
  }
}
