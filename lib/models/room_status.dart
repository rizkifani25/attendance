class RoomStatus {
  bool status;
  String statusMessage;
  String startAt;
  String dismissAt;

  RoomStatus({this.status, this.statusMessage, this.dismissAt, this.startAt});

  List<RoomStatus> getRoomStatusList() {
    return <RoomStatus>[
      RoomStatus(status: true, statusMessage: 'Booked'),
      RoomStatus(status: true, statusMessage: 'Dismissed'),
      RoomStatus(status: false, statusMessage: 'Available'),
      RoomStatus(status: true, statusMessage: 'On going'),
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    data['start_at'] = this.startAt;
    data['dismiss_at'] = this.dismissAt;
    return data;
  }

  factory RoomStatus.fromJson(Map<String, dynamic> json) {
    return RoomStatus(
      status: json['status'],
      statusMessage: json['status_message'],
      startAt: json['start_at'],
      dismissAt: json['dismiss_at'],
    );
  }
}
