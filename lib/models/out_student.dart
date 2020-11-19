import 'package:attendance/models/position.dart';

class OutStudent {
  String image;
  String time;
  PositionStudent positionStudent;
  double distance;

  OutStudent({this.image, this.time, this.positionStudent, this.distance});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image;
    data['time'] = this.time;
    data['position'] = this.positionStudent;
    data['distance'] = this.distance;
    return data;
  }

  factory OutStudent.fromJson(Map<String, dynamic> json) {
    return OutStudent(
      image: json['image'],
      time: json['time'],
      positionStudent: json['position'],
      distance: json['distance'],
    );
  }
}
