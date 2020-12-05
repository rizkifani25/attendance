part of 'login_student_bloc.dart';

abstract class LoginStudentEvent extends Equatable {
  const LoginStudentEvent();

  @override
  List<Object> get props => [];
}

class LoginStudentWithStudentId extends LoginStudentEvent {
  final String studentId;
  final String password;

  LoginStudentWithStudentId({@required this.studentId, @required this.password});

  @override
  List<Object> get props => [studentId, password];
}
