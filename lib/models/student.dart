import 'package:attendance/models/room.dart';

class Student {
  String studentId;
  String studentName;
  String password;
  String batch;
  String major;
  List<Room> historyRoom;

  Student({
    this.studentId,
    this.studentName,
    this.password,
    this.batch,
    this.major,
    this.historyRoom,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["student_id"] = this.studentId;
    data["student_name"] = this.studentName;
    data["password"] = this.password;
    data["batch"] = this.batch;
    data["major"] = this.major;
    data["history_room"] = this.historyRoom;
    return data;
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    if (json['history_room'] != null) {
      var tagObjsJson = json['history_room'] as List;
      List<Room> _historyRoom = tagObjsJson.map((e) => Room.fromJson(e)).toList();
      return Student(
        studentId: json['student_id'],
        studentName: json['student_name'],
        password: json['password'],
        batch: json['batch'],
        major: json['major'],
        historyRoom: _historyRoom,
      );
    } else {
      return Student(
        studentId: json['student_id'],
        studentName: json['student_name'],
        password: json['password'],
        batch: json['batch'],
        major: json['major'],
        historyRoom: json['history_room'],
      );
    }
  }
}
