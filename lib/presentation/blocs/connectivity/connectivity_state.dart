import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {}

class ConnectivityInitial extends ConnectivityState {
  @override
  List<Object?> get props => [];
}

class ConnectivityChecking extends ConnectivityState {
  @override
  List<Object?> get props => [];
}

class ConnectivityOffline extends ConnectivityState {
  @override
  List<Object?> get props => [];
}

class ConnectivityOnline extends ConnectivityState {
  @override
  List<Object?> get props => [];
}