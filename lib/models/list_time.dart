import 'package:attendance/models/time.dart';

class ListTime {
  Time time1;
  Time time2;
  Time time3;
  Time time4;

  ListTime({this.time1, this.time2, this.time3, this.time4});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['time1'] = this.time1;
    data['time2'] = this.time2;
    data['time3'] = this.time3;
    data['time4'] = this.time4;
    return data;
  }

  factory ListTime.fromJson(Map<String, dynamic> json) {
    return ListTime(
      time1: Time.fromJson(json['time1']),
      time2: Time.fromJson(json['time2']),
      time3: Time.fromJson(json['time3']),
      time4: Time.fromJson(json['time4']),
    );
  }
}
