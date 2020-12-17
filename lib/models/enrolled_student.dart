import 'package:attendance/models/models.dart';
import 'package:attendance/models/status_attendance.dart';

class Enrolled {
  Student student;
  StatusAttendance statusAttendance;
  AttendStudent attendStudent;
  OutStudent outStudent;
  Permission permission;

  Enrolled({this.student, this.statusAttendance, this.attendStudent, this.outStudent, this.permission});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['student'] = this.student;
    data['status'] = this.statusAttendance;
    data['attend_time'] = this.attendStudent;
    data['out_time'] = this.outStudent;
    data['permission'] = this.permission;
    return data;
  }

  factory Enrolled.fromJson(Map<String, dynamic> json) {
    return Enrolled(
      student: Student.fromJson(json['student']),
      statusAttendance: StatusAttendance.fromJson(json['status']),
      attendStudent: AttendStudent.fromJson(json['attend_time']),
      outStudent: OutStudent.fromJson(json['out_time']),
      permission: Permission.fromJson(json['permission']),
    );
  }
}
