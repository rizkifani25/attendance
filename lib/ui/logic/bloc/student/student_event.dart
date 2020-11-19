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

class StudentDoAttend extends StudentEvent {
  final String roomId;
  final String studentId;
  final String time;
  final AttendStudent attendStudent;

  StudentDoAttend({this.roomId, this.studentId, this.time, this.attendStudent});

  @override
  List<Object> get props => [roomId, studentId, time, attendStudent];
}

class StudentDoOut extends StudentEvent {
  final String roomId;
  final String studentId;
  final String time;
  final OutStudent outStudent;

  StudentDoOut({this.roomId, this.studentId, this.time, this.outStudent});

  @override
  List<Object> get props => [roomId, studentId, time, outStudent];
}
