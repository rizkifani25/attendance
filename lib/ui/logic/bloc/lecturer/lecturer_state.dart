part of 'lecturer_bloc.dart';

abstract class LecturerState extends Equatable {
  const LecturerState();
  
  @override
  List<Object> get props => [];
}

class LecturerInitial extends LecturerState {}
