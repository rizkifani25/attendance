import 'package:attendance/models/status_attendance.dart';

class Enrolled {
  final String studentId;
  final StatusAttendance statusAttendance;

  Enrolled({
    this.studentId,
    this.statusAttendance,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['status'] = this.statusAttendance;
    return data;
  }

  factory Enrolled.fromJson(Map<String, dynamic> json) {
    return Enrolled(
      studentId: json['student_id'],
      statusAttendance: StatusAttendance.fromJson(json['status']),
    );
  }
}
