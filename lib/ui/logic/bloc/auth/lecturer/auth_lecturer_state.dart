part of 'auth_lecturer_bloc.dart';

abstract class AuthLecturerState extends Equatable {
  const AuthLecturerState();

  @override
  List<Object> get props => [];
}

class AuthLecturerInitial extends AuthLecturerState {}

class AuthLecturerLoading extends AuthLecturerState {}

class AuthLecturerNotAuthenticated extends AuthLecturerState {}

class AuthLecturerAuthenticated extends AuthLecturerState {
  final Lecturer lecturer;

  AuthLecturerAuthenticated({@required this.lecturer});

  @override
  List<Object> get props => [lecturer];
}

class AuthLecturerFailure extends AuthLecturerState {
  final String message;

  AuthLecturerFailure({this.message});

  @override
  List<Object> get props => [message];
}