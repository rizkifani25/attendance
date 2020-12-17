import 'package:attendance/data/dataproviders/dataproviders.dart';
import 'package:attendance/models/lecturer.dart';
import 'package:attendance/models/models.dart';
import 'package:attendance/ui/logic/service/service.dart';
import 'package:flutter/material.dart';

class LecturerRepository {
  final AttendanceApi attendanceApi;
  LecturerRepository({@required this.attendanceApi});

  Future<BasicResponse> signInLecturer(String lecturerEmail, String password) async {
    BasicResponse basicResponse = await attendanceApi.loginLecturer(lecturerEmail, password);
    return basicResponse;
  }

  Future<BasicResponse> getLecturerLoginInfo(String lecturerEmail) async {
    BasicResponse basicResponse = await attendanceApi.findLecturer(lecturerEmail);
    return basicResponse;
  }

  Future<Lecturer> signOutLecturer() async {
    SessionManagerService().setLecturer(null);
    return null;
  }
}
