class RoomHistory {
  String roomId;

  RoomHistory({this.roomId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    return data;
  }

  factory RoomHistory.fromJson(Map<String, dynamic> json) {
    return RoomHistory(
      roomId: json['room_id'],
    );
  }
}
