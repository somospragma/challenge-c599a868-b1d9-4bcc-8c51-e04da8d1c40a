import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/constants/app_constants.dart';

class ConnectivityService {
  final Connectivity _connectivity;
  final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();
  bool _isConnected = false;

  ConnectivityService(this._connectivity) {
    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  Stream<bool> get connectivityStream => _connectivityController.stream;

  void _onConnectivityChanged(ConnectivityResult result) {
    _isConnected = result!= ConnectivityResult.none;
    _connectivityController.add(_isConnected);
  }

  Future<void> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _onConnectivityChanged(result);
    } on Exception catch (e) {
      _connectivityController.addError(ConnectionException(e.toString()));
    }
  }

  void dispose() {
    _connectivityController.close();
  }
}

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;

  ConnectivityBloc(this._connectivityService) : super(ConnectivityInitial()) {
    _connectivityService.connectivityStream.listen((isConnected) {
      add(ConnectivityChanged(isConnected));
    });
  }

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ConnectivityChanged) {
      yield event.isConnected? ConnectivityConnected() : ConnectivityDisconnected();
    }
  }
}

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
  @override
  List<Object> get props => [];
}

class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;
  const ConnectivityChanged(this.isConnected);
  @override
  List<Object> get props => [isConnected];
}

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();
  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial();
}

class ConnectivityConnected extends ConnectivityState {
  const ConnectivityConnected();
}

class ConnectivityDisconnected extends ConnectivityState {
  const ConnectivityDisconnected();
}