class Room {
  String roomId;

  Room({this.roomId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room_id'] = this.roomId;
    return data;
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['room_id'],
    );
  }
}
