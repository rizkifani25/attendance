import 'package:attendance/models/models.dart';

class PermissionStudentRequest {
  String roomId;
  String studentId;
  String time;
  Permission permission;

  PermissionStudentRequest({this.roomId, this.studentId, this.time, this.permission});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['student_id'] = this.studentId;
    data['time'] = this.time;
    data['permission'] = this.permission;
    return data;
  }

  factory PermissionStudentRequest.fromJson(Map<String, dynamic> json) {
    return PermissionStudentRequest(
      roomId: json['room_id'],
      studentId: json['student_id'],
      time: json['time'],
      permission: Permission.fromJson(json['permission']),
    );
  }
}
