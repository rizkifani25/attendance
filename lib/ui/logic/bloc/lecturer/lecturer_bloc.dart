import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lecturer_event.dart';
part 'lecturer_state.dart';

class LecturerBloc extends Bloc<LecturerEvent, LecturerState> {
  LecturerBloc() : super(LecturerInitial());

  @override
  Stream<LecturerState> mapEventToState(
    LecturerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
