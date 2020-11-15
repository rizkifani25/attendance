import 'package:attendance/data/dataproviders/attendanceAPI.dart';
import 'package:attendance/models/room_detail_response.dart';
import 'package:attendance/models/student.dart';
import 'package:flutter/cupertino.dart';

class AttendanceRepository {
  final AttendanceApi attendanceApi;
  AttendanceRepository({@required this.attendanceApi});

  Student student;

  // Student
  Future<Student> getLoginInfo(String username, String password) async {
    Student student = await attendanceApi.loginStudent(username, password);
    this.student = student;
    return student;
  }

  Future<List<RoomDetailResponse>> getRoomHistory(String studentId, String date) async {
    List<RoomDetailResponse> _roomHistory = await attendanceApi.getRoomHistory(studentId, date);
    return _roomHistory;
  }

  Future<Student> getCurrentLoginInfo() async {
    return this.student;
  }

  Future<Student> logOutAdmin() async {
    return null;
  }
}
