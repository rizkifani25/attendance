part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Lecturer Event
class AppLoadedLecturer extends AuthEvent {}

class LecturerLoggedIn extends AuthEvent {
  final Lecturer lecturer;

  LecturerLoggedIn({@required this.lecturer});

  @override
  List<Object> get props => [lecturer];
}

class LecturerLoggedOut extends AuthEvent {}

// Student Event
class AppLoadedStudent extends AuthEvent {}

class StudentLoggedIn extends AuthEvent {
  final Student student;

  StudentLoggedIn({@required this.student});

  @override
  List<Object> get props => [student];
}

class StudentLoggedOut extends AuthEvent {}
