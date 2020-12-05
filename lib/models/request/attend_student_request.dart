import 'package:attendance/models/attend_student.dart';

class AttendStudentRequest {
  String roomId;
  String studentId;
  String time;
  AttendStudent attendStudent;

  AttendStudentRequest({this.roomId, this.studentId, this.time, this.attendStudent});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['student_id'] = this.studentId;
    data['time'] = this.time;
    data['attend_time'] = this.attendStudent;
    return data;
  }

  factory AttendStudentRequest.fromJson(Map<String, dynamic> json) {
    return AttendStudentRequest(
      roomId: json['room_id'],
      studentId: json['student_id'],
      time: json['time'],
      attendStudent: AttendStudent.fromJson(json['attend_time']),
    );
  }
}
