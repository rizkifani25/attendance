part of 'auth_lecturer_bloc.dart';

abstract class AuthLecturerEvent extends Equatable {
  const AuthLecturerEvent();

  @override
  List<Object> get props => [];
}

class AppLoadedLecturer extends AuthLecturerEvent {}

class LecturerLoggedIn extends AuthLecturerEvent {
  final Lecturer lecturer;

  LecturerLoggedIn({this.lecturer});

  @override
  List<Object> get props => [lecturer];
}

class LecturerLoggedOut extends AuthLecturerEvent {}
