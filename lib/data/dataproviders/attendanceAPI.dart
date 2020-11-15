import 'dart:convert';

import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/room_detail_response.dart';
import 'package:attendance/models/student.dart';
import 'package:http/http.dart' as http;

class AttendanceApi {
  AttendanceApi();

  Future<Student> loginStudent(String studentId, String password) async {
    try {
      final String loginStudentUrl =
          apiURL + 'student/login?student_id=' + studentId + '&password=' + password;
      var response = await http.post(loginStudentUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['responseCode'] != 200) {
        throw Exception('Failure');
      }
      final String getStudentInfoUrl = apiURL + 'student/list?student_id=' + studentId;
      var studentInfoResponse = await http.post(getStudentInfoUrl);
      var studentInfoBody = jsonDecode(studentInfoResponse.body);

      return Student.fromJson(studentInfoBody['data'][0]);
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<List<RoomDetailResponse>> getRoomHistory(String studentId, String date) async {
    try {
      final String roomHistoryUrl =
          apiURL + 'student/history?student_id=' + studentId + '&date=' + date;
      print(roomHistoryUrl);
      var response = await http.post(roomHistoryUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['responseCode'] != 200) {
        throw Exception('Failure');
      }

      var responseData = responseBody['data'] as List;
      List<RoomDetailResponse> _roomHistory =
          responseData.map((e) => RoomDetailResponse.fromJson(e)).toList();

      return _roomHistory;
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }
}
