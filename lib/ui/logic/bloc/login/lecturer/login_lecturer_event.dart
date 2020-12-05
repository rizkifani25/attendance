part of 'login_lecturer_bloc.dart';

abstract class LoginLecturerEvent extends Equatable {
  const LoginLecturerEvent();

  @override
  List<Object> get props => [];
}

class LoginLecturerWithLecturerEmail extends LoginLecturerEvent {
  final String lecturerEmail;
  final String password;

  LoginLecturerWithLecturerEmail({@required this.lecturerEmail, @required this.password});

  @override
  List<Object> get props => [lecturerEmail, password];
}
