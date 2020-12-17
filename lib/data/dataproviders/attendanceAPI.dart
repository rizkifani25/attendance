import 'dart:convert';
import 'dart:io';

import 'package:attendance/constant/Constant.dart';
import 'package:attendance/models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class AttendanceApi {
  AttendanceApi();

  // Lecturer
  Future<BasicResponse> loginLecturer(String lecturerEmail, String password) async {
    BasicResponse basicResponse;
    try {
      LoginLecturerRequest loginLecturerRequest = new LoginLecturerRequest();

      loginLecturerRequest.lecturerEmail = lecturerEmail ?? '';
      loginLecturerRequest.password = password ?? '';

      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      var response = await http.post(
        apiURL + 'lecturer/login',
        body: jsonEncode(loginLecturerRequest.toJson()),
        headers: requestHeaders,
      );

      if (response.statusCode != 200) {
        basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
        return basicResponse;
      }

      basicResponse = BasicResponse.fromJson(jsonDecode(response.body));

      return basicResponse;
    } catch (e) {
      basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
      return basicResponse;
    }
  }

  Future<BasicResponse> findLecturer(String lecturerEmail) async {
    BasicResponse basicResponse;
    try {
      final String getLecturerInfoUrl = apiURL + 'lecturer/list?lecturer_email=' + lecturerEmail;
      var response = await http.post(getLecturerInfoUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      basicResponse = BasicResponse.fromJson(jsonDecode(response.body));

      return basicResponse;
    } catch (e) {
      print(e.toString());
      basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
      return basicResponse;
    }
  }

  // Student
  Future<BasicResponse> loginStudent(String studentId, String password) async {
    BasicResponse basicResponse;

    try {
      final String loginStudentUrl = apiURL + 'student/login?student_id=' + studentId + '&password=' + password;

      var response = await http.post(loginStudentUrl);
      if (response.statusCode != 200) {
        basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
        return basicResponse;
      }

      basicResponse = BasicResponse.fromJson(jsonDecode(response.body));

      return basicResponse;
    } catch (e) {
      basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
      return basicResponse;
    }
  }

  Future<Student> findStudent(String studentId) async {
    try {
      final String getStudentInfoUrl = apiURL + 'student/list?student_id=' + studentId;
      var response = await http.post(getStudentInfoUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);

      Student student = Student.fromJson(responseBody['data'][0]);

      return student;
    } catch (e) {
      print(e.toString());
      throw Exception('Failure');
    }
  }

  Future<BasicResponse> studentDoAttend(AttendStudent _attendStudent, String _roomId, String _studentId, String _time) async {
    BasicResponse basicResponse;

    try {
      await Firebase.initializeApp();
      final String roomHistoryUrl = apiURL + 'student/attend';
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      File imageFile = new File(_attendStudent.image);

      Reference ref = firebaseStorage.ref().child('attendance/' + _roomId + '/' + _studentId + '/in/' + _studentId + '.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      uploadTask.then((res) => print('upload success'));

      _attendStudent.image = 'attendance/' + _roomId + '/' + _studentId + '/in/' + _studentId + '.jpg';

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
        basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
        return basicResponse;
      }

      basicResponse = BasicResponse.fromJson(jsonDecode(response.body));

      return basicResponse;
    } catch (e) {
      print(e.toString());
      basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
      return basicResponse;
    }
  }

  Future<BasicResponse> studentDoOut(OutStudent _outStudent, String _roomId, String _studentId, String _time) async {
    BasicResponse basicResponse;

    try {
      await Firebase.initializeApp();
      final String roomHistoryUrl = apiURL + 'student/attend';
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      File imageFile = new File(_outStudent.image);

      Reference ref = firebaseStorage.ref().child('attendance/' + _roomId + '/' + _studentId + '/out/' + _studentId + '.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      uploadTask.then((res) => print('upload success'));

      _outStudent.image = 'attendance/' + _roomId + '/' + _studentId + '/out/' + _studentId + '.jpg';

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
        basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
        return basicResponse;
      }

      basicResponse = BasicResponse.fromJson(jsonDecode(response.body));

      return basicResponse;
    } catch (e) {
      print(e.toString());
      basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
      return basicResponse;
    }
  }

  // Room
  Future<BasicResponse> getInfoRoomHistory({String studentId, String lecturerEmail, String date}) async {
    BasicResponse basicResponse;
    try {
      String roomHistoryStudentUrl = apiURL + 'room/history?student_id=' + studentId + '&date=' + date;
      String roomHistoryLecturerUrl = apiURL + 'room/history?lecturer_email=' + lecturerEmail + '&date=' + date;

      final String finalUrl = studentId == null || studentId == '' ? roomHistoryLecturerUrl : roomHistoryStudentUrl;

      var response = await http.post(finalUrl);

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      basicResponse = BasicResponse.fromJson(jsonDecode(response.body));

      return basicResponse;
    } catch (e) {
      basicResponse = BasicResponse(responseCode: 400, responseMessage: 'Internal server error', data: []);
      return basicResponse;
    }
  }

  Future<BasicResponse> updateRoomDetail(String time, String roomName, String date, Time updatedTime) async {
    try {
      RegisterRoomRequest registerRoomRequest = new RegisterRoomRequest();

      registerRoomRequest.roomName = roomName;
      registerRoomRequest.updatedTime = updatedTime;
      registerRoomRequest.date = date;
      registerRoomRequest.time = time;

      Map<String, String> requestHeaders = {'Content-type': 'application/json'};

      var response = await http.post(
        apiURL + 'room/register',
        body: jsonEncode(registerRoomRequest.toJson()),
        headers: requestHeaders,
      );

      if (response.statusCode != 200) {
        throw Exception('Failure');
      }

      var responseBody = jsonDecode(response.body);
      if (responseBody['responseCode'] != 200) {
        BasicResponse basicResponse = new BasicResponse(
          responseCode: 400,
          responseMessage: responseBody['responseMessage'],
        );
        return basicResponse;
      } else {
        var responseBody = jsonDecode(response.body);
        BasicResponse basicResponse = BasicResponse.fromJson(responseBody);
        return basicResponse;
      }
    } catch (e) {
      print(e);
      throw Exception('Failure');
    }
  }
}
