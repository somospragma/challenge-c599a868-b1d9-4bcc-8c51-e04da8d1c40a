part of payment_app;

import 'package:equatable/equatable.dart';

/// Representa fallos de negocio que pueden ocurrir durante la ejecución
/// de casos de uso. Usa el patrón Either de dartz para devolver
/// estos fallos como alternativas a valores exitosos.
abstract class Failure extends Equatable {
  final String message;
  final int? code;
  final DateTime timestamp;

  const Failure(this.message, {this.code}) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [message, code, timestamp];
}

/// Fallo por falta de conexión a internet
class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

/// Fallo por timeout en la conexión
class TimeoutFailure extends Failure {
  const TimeoutFailure(String message) : super(message);
}

/// Fallo en el servidor (códigos 5xx)
class ServerFailure extends Failure {
  const ServerFailure(String message, {int? code}) : super(message, code: code);
}

/// Fallo por datos inválidos (códigos 4xx)
class InvalidDataFailure extends Failure {
  const InvalidDataFailure(String message) : super(message);
}

/// Fallo por transacción duplicada
class DuplicateTransactionFailure extends Failure {
  final String idempotencyKey;

  const DuplicateTransactionFailure(String message, this.idempotencyKey)
      : super(message);

  @override
  List<Object?> get props => [...super.props, idempotencyKey];
}

/// Fallo por límite de intentos alcanzado
class MaxRetriesReachedFailure extends Failure {
  final int attempts;

  const MaxRetriesReachedFailure(String message, this.attempts)
      : super(message);

  @override
  List<Object?> get props => [...super.props, attempts];
}

/// Fallo por umbral de latencia excedido
class SyncLatencyFailure extends Failure {
  final Duration actualLatency;

  const SyncLatencyFailure(String message, this.actualLatency) : super(message);

  @override
  List<Object?> get props => [...super.props, actualLatency];
}

/// Fallo genérico para errores no categorizados
class GenericFailure extends Failure {
  const GenericFailure(String message) : super(message);
}