import 'package:attendance/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManagerService {
  final String credentialKeyLecturer = 'lecturer_credential';
  final String credentialKeyStudent = 'student_credential';

  // Lecturer
  Future<void> setLecturer(Lecturer lecturer) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(credentialKeyLecturer, lecturer != null ? lecturer.lecturerEmail : '');
  }

  Future<String> getLecturer() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String lecturerEmail = sharedPreferences.getString(credentialKeyLecturer) ?? '';
    return lecturerEmail;
  }

  // Student
  Future<void> setStudent(Student student) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(credentialKeyStudent, student != null ? student.studentId : '');
  }

  Future<String> getStudent() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String studentId = sharedPreferences.getString(credentialKeyStudent) ?? '';
    return studentId;
  }
}
