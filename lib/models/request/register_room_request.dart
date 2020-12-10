import 'package:attendance/models/models.dart';

class RegisterRoomRequest {
  String roomName;
  Time updatedTime;
  String date;
  String time;

  RegisterRoomRequest({this.roomName, this.updatedTime, this.date, this.time});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_name'] = this.roomName ?? '-';
    data['updated_time'] = this.updatedTime;
    data['date'] = this.date ?? '-';
    data['time'] = this.time ?? '-';
    return data;
  }

  factory RegisterRoomRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRoomRequest(
      roomName: json['room_name'] ?? '-',
      updatedTime: Time.fromJson(json['updated_time']),
      date: json['date'] ?? '-',
      time: json['time'] ?? '-',
    );
  }

  @override
  String toString() {
    return 'RegisterRoomRequest(roomName: $roomName, updatedTime: $updatedTime, date: $date, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RegisterRoomRequest && o.roomName == roomName && o.updatedTime == updatedTime && o.date == date && o.time == time;
  }

  @override
  int get hashCode {
    return roomName.hashCode ^ updatedTime.hashCode ^ date.hashCode ^ time.hashCode;
  }
}
