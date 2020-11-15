part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStudentWithStudentId extends LoginEvent {
  final String studentId;
  final String password;

  LoginStudentWithStudentId({@required this.studentId, @required this.password});

  @override
  List<Object> get props => [studentId, password];
}
