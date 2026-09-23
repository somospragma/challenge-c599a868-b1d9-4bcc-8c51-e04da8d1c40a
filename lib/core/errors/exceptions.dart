part of payment_app;

import 'package:payment_app/core/constants/app_constants.dart';

/// Excepciones personalizadas para manejar errores en la capa de datos
/// y propagarlos a la capa de dominio como Failures.
///
/// Estas excepciones son lanzadas por los datasources y repositorios
/// y deben ser capturadas para mapearse a Failures correspondientes.

/// Excepción base para errores en la aplicación
abstract class AppException implements Exception {
  final String message;
  final DateTime timestamp;

  const AppException(this.message) : timestamp = DateTime.now();

  @override
  String toString() => '$runtimeType: $message';
}

/// Excepción lanzada cuando no hay conexión a internet
class ConnectionException extends AppException {
  ConnectionException()
      : super(AppConstants.connectionErrorMessage);
}

/// Excepción lanzada cuando se agota el tiempo de espera
class TimeoutException extends AppException {
  TimeoutException()
      : super(AppConstants.timeoutErrorMessage);
}

/// Excepción lanzada por errores en el servidor
class ServerException extends AppException {
  final int? statusCode;

  ServerException(String message, {this.statusCode})
      : super(message);
}

/// Excepción lanzada por datos inválidos
class InvalidDataException extends AppException {
  InvalidDataException(String message) : super(message);
}

/// Excepción lanzada por transacción duplicada
class DuplicateTransactionException extends AppException {
  final String idempotencyKey;

  DuplicateTransactionException(this.idempotencyKey)
      : super(AppConstants.duplicateTransactionMessage);
}

/// Excepción lanzada por límite de intentos alcanzado
class MaxRetriesReachedException extends AppException {
  final int attempts;

  MaxRetriesReachedException(this.attempts)
      : super('Máximo de intentos alcanzado: $attempts');
}

/// Excepción lanzada cuando la latencia de sincronización excede el umbral
class SyncLatencyException extends AppException {
  final Duration actualLatency;

  SyncLatencyException(this.actualLatency)
      : super('Latencia de sincronización excedida: ${actualLatency.inSeconds}s');
}

/// Excepción lanzada cuando se intenta guardar una transacción que ya existe
class TransactionAlreadyExistsException extends AppException {
  final String transactionId;

  TransactionAlreadyExistsException(this.transactionId)
      : super('Transacción $transactionId ya existe');
}

/// Excepción lanzada cuando la base de datos local no está disponible
class DatabaseException extends AppException {
  DatabaseException(String message) : super(message);
}

/// Excepción lanzada cuando se alcanza el límite de transacciones pendientes
class MaxPendingTransactionsException extends AppException {
  MaxPendingTransactionsException()
      : super('Límite de transacciones pendientes alcanzado');
}

/// Excepción lanzada por transacción expirada
class TransactionExpiredException extends AppException {
  final String transactionId;

  TransactionExpiredException(this.transactionId)
      : super('Transacción $transactionId expirada');
}