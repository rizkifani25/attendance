import 'package:attendance/models/models.dart';

class OutStudent {
  String image;
  DateTime time;
  PositionStudent positionStudent;
  double distance;

  OutStudent({this.image, this.time, this.positionStudent, this.distance});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image;
    data['time'] = this.time.toString();
    data['position'] = this.positionStudent;
    data['distance'] = this.distance;
    return data;
  }

  factory OutStudent.fromJson(Map<String, dynamic> json) {
    return OutStudent(
      image: json['image'],
      time: DateTime.parse(json['time']),
      positionStudent: PositionStudent.fromJson(json['position']),
      distance: json['distance'].toDouble(),
    );
  }
}
