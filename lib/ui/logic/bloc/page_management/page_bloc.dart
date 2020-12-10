import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is RenderSelectedPage) {
      yield* _mapRenderSelectedPageToState(event);
    }
  }

  Stream<PageState> _mapRenderSelectedPageToState(RenderSelectedPage event) async* {
    if (event.pageState == 'loginLecturer') {
      yield LecturerLoginViewState();
    } else if (event.pageState == 'loginStudent') {
      yield StudentLoginViewState();
    } else {
      yield PageLoading();
    }
  }
}
