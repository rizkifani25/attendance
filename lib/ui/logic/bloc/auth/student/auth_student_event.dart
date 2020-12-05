part of 'auth_student_bloc.dart';

abstract class AuthStudentEvent extends Equatable {
  const AuthStudentEvent();

  @override
  List<Object> get props => [];
}

class AppLoadedStudent extends AuthStudentEvent {}

class StudentLoggedIn extends AuthStudentEvent {
  final Student student;

  StudentLoggedIn({@required this.student});

  @override
  List<Object> get props => [student];
}

class StudentLoggedOut extends AuthStudentEvent {}
