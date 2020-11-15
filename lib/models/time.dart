import 'package:attendance/models/enrolled_student.dart';

class Time {
  bool status;
  String time;
  List<Enrolled> enrolled;
  String lecturer;
  String subject;

  Time({
    this.time,
    this.status,
    this.enrolled,
    this.lecturer,
    this.subject,
  });

  static List<String> getRoomTime() {
    return [
      '07.30 - 09.30',
      '10.00 - 12.00',
      '12.30 - 14.30',
      '15.00 - 17.00',
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['time'] = this.time;
    data['status'] = this.status;
    data['enrolled'] = this.enrolled;
    data['lecturer'] = this.lecturer;
    data['subject'] = this.subject;
    return data;
  }

  factory Time.fromJson(Map<String, dynamic> json) {
    if (json['enrolled'] != null) {
      var tagObjsJson = json['enrolled'] as List;
      List<Enrolled> _enrolled = tagObjsJson.map((e) => Enrolled.fromJson(e)).toList();

      return Time(
        time: json['time'],
        status: json['status'],
        enrolled: _enrolled,
        lecturer: json['lecturer'],
        subject: json['subject'],
      );
    } else {
      return Time(
        time: json['time'],
        status: json['status'],
        enrolled: json['enrolled'],
        lecturer: json['lecturer'],
        subject: json['subject'],
      );
    }
  }
}
