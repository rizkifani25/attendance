import 'package:attendance/models/out_student.dart';

class OutStudentRequest {
  String roomId;
  String studentId;
  String time;
  OutStudent outStudent;

  OutStudentRequest({this.roomId, this.studentId, this.time, this.outStudent});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['student_id'] = this.studentId;
    data['time'] = this.time;
    data['out_time'] = this.outStudent;
    return data;
  }

  factory OutStudentRequest.fromJson(Map<String, dynamic> json) {
    return OutStudentRequest(
      roomId: json['room_id'],
      studentId: json['student_id'],
      time: json['time'],
      outStudent: OutStudent.fromJson(json['out_time']),
    );
  }
}
