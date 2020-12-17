part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class ListenConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  final NetworkState connection;

  ConnectionChanged({this.connection});

  @override
  List<Object> get props => [connection];
}
