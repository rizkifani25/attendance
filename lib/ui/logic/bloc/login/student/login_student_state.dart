part of 'login_student_bloc.dart';

abstract class LoginStudentState extends Equatable {
  const LoginStudentState();

  @override
  List<Object> get props => [];
}

class LoginStudentInitial extends LoginStudentState {}

class LoginStudentLoading extends LoginStudentState {}

class LoginStudentSuccess extends LoginStudentState {}

class LoginStudentFailure extends LoginStudentState {
  final String message;

  LoginStudentFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
