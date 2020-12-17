import 'package:attendance/models/models.dart';

class Lecturer {
  String lecturerEmail;
  String lecturerName;
  String password;
  List<RoomHistory> historyRoom;

  Lecturer({this.lecturerEmail, this.lecturerName, this.password, this.historyRoom});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["lecturer_email"] = this.lecturerEmail;
    data["lecturer_name"] = this.lecturerName;
    data["password"] = this.password;
    data["history_room"] = this.historyRoom;
    return data;
  }

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    if (json['history_room'] != null) {
      var tagObjsJson = json['history_room'] as List;
      List<RoomHistory> _historyRoom = tagObjsJson.map((e) => RoomHistory.fromJson(e)).toList();

      return Lecturer(
        lecturerEmail: json['lecturer_email'],
        lecturerName: json['lecturer_name'],
        password: json['password'],
        historyRoom: _historyRoom,
      );
    } else {
      return Lecturer(
        lecturerEmail: json['lecturer_email'],
        lecturerName: json['lecturer_name'],
        password: json['password'],
        historyRoom: json['history_room'],
      );
    }
  }
}
