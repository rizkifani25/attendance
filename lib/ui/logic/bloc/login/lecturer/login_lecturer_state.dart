part of 'login_lecturer_bloc.dart';

abstract class LoginLecturerState extends Equatable {
  const LoginLecturerState();

  @override
  List<Object> get props => [];
}

class LoginLecturerInitial extends LoginLecturerState {}

class LoginLecturerLoading extends LoginLecturerState {}

class LoginLecturerSuccess extends LoginLecturerState {}

class LoginLecturerFailure extends LoginLecturerState {
  final String message;

  LoginLecturerFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
