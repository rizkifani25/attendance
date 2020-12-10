class RoomStatus {
  bool status;
  String statusMessage;

  RoomStatus({this.status, this.statusMessage});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status ?? false;
    data['status_message'] = this.statusMessage ?? '-';
    return data;
  }

  factory RoomStatus.fromJson(Map<String, dynamic> json) {
    return RoomStatus(
      status: json['status'] ?? false,
      statusMessage: json['status_message'] ?? '-',
    );
  }
}
