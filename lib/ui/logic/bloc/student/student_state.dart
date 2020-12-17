part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoadingHistory extends StudentState {}

class StudentFetchLoading extends StudentState {}

class StudentFetchSuccess extends StudentState {}

class StudentFetchFailed extends StudentState {
  final String message;

  StudentFetchFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class StudentLoadHistory extends StudentState {
  final List<RoomDetail> roomHistory;

  StudentLoadHistory({this.roomHistory});

  @override
  List<Object> get props => [roomHistory];
}

class StudentLoadHistorySuccess extends StudentState {}

class StudentLoadHistoryFailed extends StudentState {
  final String message;

  StudentLoadHistoryFailed({@required this.message});

  @override
  List<Object> get props => [message];
}
