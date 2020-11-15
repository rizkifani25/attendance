part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetRoomHistory extends StudentEvent {
  final String studentId;
  final String date;

  GetRoomHistory({this.studentId, this.date});

  @override
  List<Object> get props => [studentId, date];
}
