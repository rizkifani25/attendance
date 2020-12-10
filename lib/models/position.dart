class PositionStudent {
  double latitude;
  double longitude;

  PositionStudent({this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['latitude'] = this.latitude ?? 0.0;
    data['longitude'] = this.longitude ?? 0.0;
    return data;
  }

  factory PositionStudent.fromJson(Map<String, dynamic> json) {
    return PositionStudent(
      latitude: json['latitude'].toDouble() ?? 0.0,
      longitude: json['longitude'].toDouble() ?? 0.0,
    );
  }

  @override
  String toString() => 'PositionStudent(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PositionStudent && o.latitude == latitude && o.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
