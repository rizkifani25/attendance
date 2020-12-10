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

  @override
  String toString() {
    return 'Enrolled(student: $student, statusAttendance: $statusAttendance, attendStudent: $attendStudent, outStudent: $outStudent, permission: $permission)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Enrolled && o.student == student && o.statusAttendance == statusAttendance && o.attendStudent == attendStudent && o.outStudent == outStudent && o.permission == permission;
  }

  @override
  int get hashCode {
    return student.hashCode ^ statusAttendance.hashCode ^ attendStudent.hashCode ^ outStudent.hashCode ^ permission.hashCode;
  }
}
