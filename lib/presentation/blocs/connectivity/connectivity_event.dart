import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {}

class ConnectivityGained extends ConnectivityEvent {
  @override
  List<Object?> get props => [];
}

class ConnectivityLost extends ConnectivityEvent {
  @override
  List<Object?> get props => [];
}