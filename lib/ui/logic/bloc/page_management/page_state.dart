part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class PageInitial extends PageState {}

class PageLoading extends PageState {}

// login view
class StudentLoginViewState extends PageState {}

class LecturerLoginViewState extends PageState {}

// student view
class PageRoomView extends PageState {}

class PageLecturerView extends PageState {}

class PageStudentView extends PageState {}

// lecturer view
