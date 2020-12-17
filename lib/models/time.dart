import 'models.dart';

class Time {
  RoomStatus status;
  String time;
  DateTime punchIn;
  DateTime punchOut;
  List<Enrolled> enrolled;
  Lecturer lecturer;
  String subject;

  Time({this.time, this.punchIn, this.punchOut, this.status, this.enrolled, this.lecturer, this.subject});

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
    data['punch_in'] = this.punchIn;
    data['punch_out'] = this.punchOut;
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
        punchIn: DateTime.parse(json['punch_in']),
        punchOut: DateTime.parse(json['punch_out']),
        status: RoomStatus.fromJson(json['status']),
        enrolled: _enrolled,
        lecturer: Lecturer.fromJson(json['lecturer']),
        subject: json['subject'],
      );
    } else {
      return Time(
        time: json['time'],
        punchIn: DateTime.parse(json['punch_in']),
        punchOut: DateTime.parse(json['punch_out']),
        status: RoomStatus.fromJson(json['status']),
        enrolled: json['enrolled'],
        lecturer: Lecturer.fromJson(json['lecturer']),
        subject: json['subject'],
      );
    }
  }
}
