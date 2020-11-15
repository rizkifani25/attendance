class Room {
  String roomId;
  int status;

  Room({this.roomId, this.status});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['status'] = this.status;
    return data;
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['room_id'],
      status: json['status'],
    );
  }
}
