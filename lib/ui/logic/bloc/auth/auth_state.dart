part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// State Lecturer
class AuthLecturerNotAuthenticated extends AuthState {}

class AuthLecturerAuthenticated extends AuthState {
  final Lecturer lecturer;

  AuthLecturerAuthenticated({@required this.lecturer});

  @override
  List<Object> get props => [lecturer];
}

// State Student
class AuthStudentNotAuthenticated extends AuthState {}

class AuthStudentAuthenticated extends AuthState {
  final Student student;

  AuthStudentAuthenticated({@required this.student});

  @override
  List<Object> get props => [student];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({this.message});

  @override
  List<Object> get props => [message];
}
