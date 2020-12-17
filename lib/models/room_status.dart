class RoomStatus {
  int id;
  bool status;
  String statusMessage;

  RoomStatus({this.id, this.status, this.statusMessage});

  List<RoomStatus> getRoomStatusList() {
    return <RoomStatus>[
      RoomStatus(id: 1, status: true, statusMessage: 'Booked'),
      RoomStatus(id: 2, status: true, statusMessage: 'Dismissed'),
      RoomStatus(id: 3, status: false, statusMessage: 'Available'),
      RoomStatus(id: 4, status: true, statusMessage: 'On going'),
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    return data;
  }

  factory RoomStatus.fromJson(Map<String, dynamic> json) {
    return RoomStatus(
      status: json['status'],
      statusMessage: json['status_message'],
    );
  }
}
