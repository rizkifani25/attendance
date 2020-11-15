part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final Student student;

  UserLoggedIn({@required this.student});

  @override
  List<Object> get props => [student];
}

class UserLoggedOut extends AuthEvent {}
