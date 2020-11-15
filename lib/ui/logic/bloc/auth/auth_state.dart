part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Student student;

  AuthAuthenticated({@required this.student});

  @override
  List<Object> get props => [student];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
