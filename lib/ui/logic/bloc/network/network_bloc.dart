import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitial());

  StreamSubscription _streamSubscription;

  @override
  Stream<NetworkState> mapEventToState(
    NetworkEvent event,
  ) async* {
    if (event is ListenConnection) {
      yield* _mapListenConnectionToState(event);
    }
    if (event is ConnectionChanged) {
      yield* _mapConnectionChangedToState(event);
    }
  }

  Stream<NetworkState> _mapListenConnectionToState(ListenConnection event) async* {
    _streamSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      add(ConnectionChanged(connection: result == ConnectivityResult.none ? NetworkFailure() : NetworkSuccess()));
    });
  }

  Stream<NetworkState> _mapConnectionChangedToState(ConnectionChanged event) async* {
    yield event.connection;
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
