import 'dart:convert';
import 'dart:io';

import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/attend_student.dart';
import 'package:attendance/models/attend_student_request.dart';
import 'package:attendance/models/basic_response.dart';
import 'package:attendance/models/out_student.dart';
import 'package:attendance/models/out_student_request.dart';
import 'package:attendance/models/room_detail_response.dart';
import 'package:attendance/models/student.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<BasicResponse> studentDoAttend(
    AttendStudent _attendStudent,
    String _roomId,
    String _studentId,
    String _time,
  ) async {
    try {
      await Firebase.initializeApp();
      final String roomHistoryUrl = apiURL + 'student/attend';
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      File imageFile = new File(_attendStudent.image);

      Reference ref = firebaseStorage
          .ref()
          .child('attendance/' + _roomId + '/' + _studentId + '/' + _studentId + '-in');
      UploadTask uploadTask = ref.putFile(imageFile);
      uploadTask.then((res) => res.ref.getDownloadURL());

      _attendStudent.image = 'attendance/' + _roomId + '/' + _studentId + '/' + _studentId + '-in';

      print('masuk sini');
      AttendStudentRequest attendStudentRequest = new AttendStudentRequest();
      attendStudentRequest.attendStudent = _attendStudent;
      attendStudentRequest.roomId = _roomId;
      attendStudentRequest.studentId = _studentId;
      attendStudentRequest.time = _time;

      print(jsonEncode(attendStudentRequest.toJson()));

      var response = await http.post(
        roomHistoryUrl,
        headers: requestHeaders,
        body: jsonEncode(attendStudentRequest.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['responseCode'] != 200) {
        throw Exception('Failure');
      }

      return null;
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<BasicResponse> studentDoOut(
    OutStudent _outStudent,
    String _roomId,
    String _studentId,
    String _time,
  ) async {
    try {
      await Firebase.initializeApp();
      final String roomHistoryUrl = apiURL + 'student/attend';
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      File imageFile = new File(_outStudent.image);

      Reference ref = firebaseStorage
          .ref()
          .child('attendance/' + _roomId + '/' + _studentId + '/' + _studentId + '-out');
      UploadTask uploadTask = ref.putFile(imageFile);
      uploadTask.then((res) => res.ref.getDownloadURL());

      _outStudent.image = 'attendance/' + _roomId + '/' + _studentId + '/' + _studentId + '-out';

      print('masuk sini');
      OutStudentRequest outStudentRequest = new OutStudentRequest();
      outStudentRequest.outStudent = _outStudent;
      outStudentRequest.roomId = _roomId;
      outStudentRequest.studentId = _studentId;
      outStudentRequest.time = _time;

      print(jsonEncode(outStudentRequest.toJson()));

      var response = await http.post(
        roomHistoryUrl,
        headers: requestHeaders,
        body: jsonEncode(outStudentRequest.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['responseCode'] != 200) {
        throw Exception('Failure');
      }

      return null;
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }
}
