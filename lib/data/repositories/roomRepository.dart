import 'package:attendance/data/dataproviders/attendanceAPI.dart';
import 'package:attendance/models/models.dart';
import 'package:flutter/cupertino.dart';

class RoomRepository {
  final AttendanceApi attendanceApi;
  RoomRepository({@required this.attendanceApi});

  Future<BasicResponse> getInfoRoomHistory({String studentId, String lecturerEmail, String date}) async {
    BasicResponse basicResponse = await attendanceApi.getInfoRoomHistory(studentId: studentId, lecturerEmail: lecturerEmail, date: date);
    return basicResponse;
  }

  Future<BasicResponse> updateRoomData(String time, String roomName, String date, Time updatedTime) async {
    BasicResponse basicResponse = await attendanceApi.updateRoomDetail(time, roomName, date, updatedTime);
    return basicResponse;
  }
}
