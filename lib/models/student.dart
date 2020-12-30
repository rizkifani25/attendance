import 'package:attendance/models/models.dart';

class Student {
  String studentId;
  String studentName;
  String password;
  String batch;
  String major;
  String baseImagePath;
  List<RoomHistory> historyRoom;

  Student({this.studentId, this.studentName, this.password, this.batch, this.major, this.baseImagePath, this.historyRoom});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["student_id"] = this.studentId;
    data["student_name"] = this.studentName;
    data["password"] = this.password;
    data["batch"] = this.batch;
    data["major"] = this.major;
    data["base_image"] = this.baseImagePath;
    data["history_room"] = this.historyRoom;
    return data;
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    if (json['history_room'] != null) {
      var tagObjsJson = json['history_room'] as List;
      List<RoomHistory> _historyRoom = tagObjsJson.map((e) => RoomHistory.fromJson(e)).toList();

      return Student(
        studentId: json['student_id'],
        studentName: json['student_name'],
        password: json['password'],
        batch: json['batch'],
        major: json['major'],
        baseImagePath: json['base_image'],
        historyRoom: _historyRoom,
      );
    } else {
      return Student(
        studentId: json['student_id'],
        studentName: json['student_name'],
        password: json['password'],
        batch: json['batch'],
        major: json['major'],
        baseImagePath: json['base_image'],
        historyRoom: json['history_room'],
      );
    }
  }
}
