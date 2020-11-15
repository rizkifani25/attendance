part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoadingHistory extends StudentState {}

class StudentLoadHistory extends StudentState {
  final List<RoomDetailResponse> roomHistory;

  StudentLoadHistory({this.roomHistory});

  @override
  List<Object> get props => [roomHistory];
}

class StudentLoadHistoryFailed extends StudentState {
  final String message;

  StudentLoadHistoryFailed({@required this.message});

  @override
  List<Object> get props => [message];
}
