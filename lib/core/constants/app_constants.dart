part of payment_app;

/// Constantes globales de la aplicación para umbrales, configuraciones de red
/// y valores predeterminados que requieren consistencia en toda la app.
class AppConstants {
  // Umbrales de sincronización
  static const int syncLatencyThreshold = 5;
  static const Duration syncLatencyDuration = Duration(seconds: syncLatencyThreshold);
  static const int maxRetryAttempts = 3;
  static const Duration initialRetryDelay = Duration(milliseconds: 500);
  static const double retryBackoffMultiplier = 2.0;

  // Configuración de red
  static const String baseApiUrl = 'https://api.payment-service.com/v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const String contentTypeJson = 'application/json';
  static const String syncEndpoint = '/transactions/sync';

  // Configuración de persistencia
  static const String databaseName = 'payment_database.db';
  static const int databaseVersion = 1;
  static const String pendingTransactionsTable = 'pending_transactions';
  static const String transactionsTable = 'transactions';
  static const String syncStatusPending = 'pending';
  static const String syncStatusSynced = 'synced';
  static const String syncStatusFailed = 'failed';

  // Límites de negocio
  static const double minTransactionAmount = 0.01;
  static const double maxTransactionAmount = 10000.0;
  static const int maxPendingTransactions = 100;
  static const Duration pendingTransactionExpiry = Duration(days: 7);

  // Configuración de idempotencia
  static const String idempotencyPrefix = 'idemp_';
  static const int idempotencyKeyLength = 36;

  // Mensajes de error
  static const String connectionErrorMessage = 'No se pudo establecer conexión con el servidor';
  static const String timeoutErrorMessage = 'Tiempo de espera agotado';
  static const String serverErrorMessage = 'Error en el servidor';
  static const String invalidTransactionMessage = 'Transacción inválida';
  static const String duplicateTransactionMessage = 'Transacción duplicada';
  static const String syncInProgressMessage = 'Sincronización en progreso';
  static const String offlineModeMessage = 'Modo offline activado';

  // Configuración de logs
  static const String logTag = 'PaymentApp';
  static const bool enableDebugLogs = true;

  // Configuración de seguridad
  static const String encryptionKey = 'payment_app_encryption_key_2024';
  static const String encryptionIv = 'initialization_v';
}