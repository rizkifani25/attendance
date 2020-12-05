part of 'auth_student_bloc.dart';

abstract class AuthStudentState extends Equatable {
  const AuthStudentState();

  @override
  List<Object> get props => [];
}

class AuthStudentInitial extends AuthStudentState {}

class AuthStudentLoading extends AuthStudentState {}

class AuthStudentNotAuthenticated extends AuthStudentState {}

class AuthStudentAuthenticated extends AuthStudentState {
  final Student student;

  AuthStudentAuthenticated({@required this.student});

  @override
  List<Object> get props => [student];
}

class AuthStudentAuthFailure extends AuthStudentState {
  final String message;

  AuthStudentAuthFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
