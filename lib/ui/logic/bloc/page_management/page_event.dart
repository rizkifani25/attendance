part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class RenderSelectedPage extends PageEvent {
  final String pageState;

  RenderSelectedPage({this.pageState});

  @override
  List<Object> get props => [pageState];
}
