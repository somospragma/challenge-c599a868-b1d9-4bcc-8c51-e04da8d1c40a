# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `lib/data/datasources/local/database_helper.dart` — El topic pide persistencia: este archivo es el ejercicio.
- `lib/data/repositories/transaction_repository_impl.dart` — El topic pide persistencia: este archivo es el ejercicio.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `lib/domain/usecases/sync_pending_transactions.dart` — `TransactionRepository.syncTransaction`: Se invoca `syncTransaction` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/domain/usecases/check_transaction_idempotency.dart` — `TransactionRepository.getTransactionByIdempotencyKey`: Se invoca `getTransactionByIdempotencyKey` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/datasources/remote/transaction_remote_datasource.dart` — `ConnectivityService.isConnected`: Se invoca `isConnected` sobre `ConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/datasources/remote/transaction_remote_datasource.dart` — `IdempotencyGenerator.generate`: Se invoca `generate` sobre `IdempotencyGenerator`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/datasources/remote/transaction_remote_datasource.dart` — `TransactionEntity.toJson`: Se invoca `toJson` sobre `TransactionEntity`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/blocs/connectivity/connectivity_bloc.dart` — `GetPendingTransactions.execute`: Se invoca `execute` sobre `GetPendingTransactions`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/blocs/connectivity/connectivity_bloc.dart` — `CheckTransactionIdempotency.execute`: Se invoca `execute` sobre `CheckTransactionIdempotency`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/blocs/connectivity/connectivity_bloc.dart` — `SyncPendingTransactions.execute`: Se invoca `execute` sobre `SyncPendingTransactions`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/repositories/transaction_repository_impl_test.dart` — `MockTransactionRemoteDatasource.syncTransaction`: Se invoca `syncTransaction` sobre `MockTransactionRemoteDatasource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/mocks/mock_transaction_remote_datasource.dart` — `MockTransactionRemoteDatasource.sendTransaction`: Se invoca `sendTransaction` sobre `MockTransactionRemoteDatasource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
flutter pub get && flutter analyze
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior

### Brecha de conocimiento
Maneja estado y flujos asincronicos con persistencia local y sincronizacion posterior

### Misión / candidato
Soportar operacion sin conexion en la app de pagos

### Datos adicionales
Candidato con 4 años en Flutter

### Reto
- Tema: persistencia local y modo offline
- Seniority: senior-l2
- Tipo: practical
- Título: Implementación de modo offline en la app de pagos
- Tiempo estimado: 10 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Diseño del almacén local de datos — objetivo: Definir la estructura del almacén local que permitirá almacenar transacciones sin conexión. — entregable (NO resolver): Especificación del diseño del almacén local de datos.
- Fase 2: Implementación de la persistencia local — objetivo: Implementar la funcionalidad para almacenar transacciones localmente cuando no hay conexión. — entregable (NO resolver): Código funcional para la persistencia local de transacciones.
- Fase 3: Sincronización de transacciones — objetivo: Implementar la funcionalidad para sincronizar transacciones almacenadas localmente con el servicio de pagos una vez que se restablezca la conexión. — entregable (NO resolver): Código funcional para la sincronización de transacciones.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pubspec.yaml ===
name: payment_app
description: Aplicación de pagos con soporte para modo offline y sincronización de transacciones.

version: 1.0.0+1

environment:
  sdk: '>=3.6.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.0
  drift: ^2.26.0
  sqlite3_flutter_libs: ^0.5.32
  path_provider: ^2.1.5
  path: ^1.9.1
  connectivity_plus: ^6.1.4
  dio: ^5.8.0
  get_it: ^8.0.3
  dartz: ^0.10.1
  uuid: ^4.5.1
  equatable: ^2.0.7
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  drift_dev: ^2.26.0
  build_runner: ^2.4.15
  mocktail: ^1.0.4
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true

# Configuración para generación de código con drift
# Ejecutar: flutter pub run build_runner build

drift:
  sqlite:
    queries:
      pending_transactions: |
        CREATE TABLE pending_transactions (
          id TEXT PRIMARY KEY,
          amount REAL NOT NULL,
          recipient TEXT NOT NULL,
          timestamp INTEGER NOT NULL,
          sync_status TEXT NOT NULL,
          idempotency_key TEXT NOT NULL
        );
      transactions: |
        CREATE TABLE transactions (
          id TEXT PRIMARY KEY,
          amount REAL NOT NULL,
          recipient TEXT NOT NULL,
          timestamp INTEGER NOT NULL,
          sync_status TEXT NOT NULL
        );

// === ARCHIVO: lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/di/injection_container.dart' as di;
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/domain/usecases/check_transaction_idempotency.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions.dart';
import 'package:payment_app/domain/usecases/save_transaction_locally.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/presentation/blocs/connectivity/connectivity_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/screens/payment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc(
            connectivityService: GetIt.instance<ConnectivityService>(),
          )..add(CheckConnectivity()),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(
            saveTransactionLocally: GetIt.instance<SaveTransactionLocally>(),
            syncPendingTransactions: GetIt.instance<SyncPendingTransactions>(),
            getPendingTransactions: GetIt.instance<GetPendingTransactions>(),
            checkTransactionIdempotency: GetIt.instance<CheckTransactionIdempotency>(),
            transactionRepository: GetIt.instance<TransactionRepository>(),
          )..add(LoadPendingTransactions()),
        ),
      ],
      child: MaterialApp(
        title: 'Payment App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PaymentScreen(),
      ),
    );
  }
}

// === ARCHIVO: lib/core/constants/app_constants.dart ===
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

// === ARCHIVO: lib/core/errors/failures.dart ===
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

// === ARCHIVO: lib/core/errors/exceptions.dart ===
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

// === ARCHIVO: lib/core/network/connectivity_service.dart ===
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

// === ARCHIVO: lib/core/utils/idempotency_generator.dart ===
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:payment_app/core/constants/app_constants.dart';

class IdempotencyGenerator {
  final Uuid _uuid = Uuid();

  String generateIdempotencyKey() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final prefix = AppConstants.idempotencyPrefix;
    final length = AppConstants.idempotencyKeyLength;

    final randomChars = List.generate(length - prefix.length - timestamp.length, (index) => random.nextInt(36).toRadixString(36)).join();

    return '$prefix-$timestamp-$randomChars';
  }

  bool validateIdempotencyKey(String key) {
    if (key.length!= AppConstants.idempotencyKeyLength) {
      return false;
    }

    final parts = key.split('-');
    if (parts.length!= 3) {
      return false;
    }

    final prefix = parts[0];
    final timestamp = parts[1];
    final randomChars = parts[2];

    if (prefix!= AppConstants.idempotencyPrefix) {
      return false;
    }

    try {
      final timestampInt = int.parse(timestamp);
      if (timestampInt < DateTime.now().subtract(AppConstants.pendingTransactionExpiry).millisecondsSinceEpoch) {
        return false;
      }
    } catch (e) {
      return false;
    }

    if (randomChars.length!= AppConstants.idempotencyKeyLength - prefix.length - timestamp.length) {
      return false;
    }

    return true;
  }
}

// === ARCHIVO: lib/domain/entities/transaction_entity.dart ===
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'sync_status.dart';

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String recipient;
  final int timestamp;
  final SyncStatus syncStatus;
  final String idempotencyKey;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.recipient,
    required this.timestamp,
    required this.syncStatus,
    required this.idempotencyKey,
  });

  @override
  List<Object?> get props => [id, amount, recipient, timestamp, syncStatus, idempotencyKey];

  TransactionEntity copyWith({
    String? id,
    double? amount,
    String? recipient,
    int? timestamp,
    SyncStatus? syncStatus,
    String? idempotencyKey,
  }) {
    return TransactionEntity(
      id: id?? this.id,
      amount: amount?? this.amount,
      recipient: recipient?? this.recipient,
      timestamp: timestamp?? this.timestamp,
      syncStatus: syncStatus?? this.syncStatus,
      idempotencyKey: idempotencyKey?? this.idempotencyKey,
    );
  }
}

// === ARCHIVO: lib/domain/entities/sync_status.dart ===
enum SyncStatus {
  pending,
  synced,
  failed,
}

// === ARCHIVO: lib/domain/repositories/transaction_repository.dart ===
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getPendingTransactions();
  Future<Either<Failure, Unit>> saveTransactionLocally(TransactionEntity transaction);
  Future<Either<Failure, Unit>> syncPendingTransactions();
  Future<Either<Failure, bool>> checkTransactionIdempotency(String idempotencyKey);

  void dispose();

  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByStatus(SyncStatus status);
  Future<Either<Failure, TransactionEntity>> getTransactionById(String id);
  Future<Either<Failure, Unit>> updateTransactionStatus(TransactionEntity transaction);
  Future<Either<Failure, Unit>> deleteTransaction(String id);
  Future<Either<Failure, List<TransactionEntity>>> getExpiredTransactions();
  Future<Either<Failure, Unit>> retryFailedTransactions();
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByAmountRange(double minAmount, double maxAmount);
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(int startDate, int endDate);
}

// === ARCHIVO: lib/domain/usecases/save_transaction_locally.dart ===
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class SaveTransactionLocally {
  final TransactionRepository repository;
  SaveTransactionLocally(this.repository);

  Future<Either<Failure, Unit>> call(TransactionEntity transaction) async {
    try {
      final idempotencyKey = const Uuid().v4();
      final transactionWithIdempotency = transaction.copyWith(idempotencyKey: idempotencyKey);
      await repository.saveTransactionLocally(transactionWithIdempotency);
      return Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } on MaxPendingTransactionsException {
      return Left(MaxPendingTransactionsFailure());
    } catch (e) {
      return Left(GenericFailure(message: 'Error al guardar la transacción localmente'));
    }
  }
}

// === ARCHIVO: lib/domain/usecases/sync_pending_transactions.dart ===
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class SyncPendingTransactions {
  final TransactionRepository repository;
  SyncPendingTransactions(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    try {
      final pendingTransactions = await repository.getPendingTransactions();
      for (var transaction in pendingTransactions) {
        await repository.syncTransaction(transaction);
      }
      return Right(pendingTransactions);
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } on SyncLatencyException catch (e) {
      return Left(SyncLatencyFailure(message: e.message, actualLatency: e.actualLatency));
    } catch (e) {
      return Left(GenericFailure(message: 'Error al sincronizar transacciones pendientes'));
    }
  }
}

// === ARCHIVO: lib/domain/usecases/get_pending_transactions.dart ===
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class GetPendingTransactions {
  final TransactionRepository repository;
  GetPendingTransactions(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    try {
      final pendingTransactions = await repository.getPendingTransactions();
      return Right(pendingTransactions);
    } catch (e) {
      return Left(GenericFailure(message: 'Error al obtener transacciones pendientes'));
    }
  }
}

// === ARCHIVO: lib/domain/usecases/check_transaction_idempotency.dart ===
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class CheckTransactionIdempotency {
  final TransactionRepository repository;

  CheckTransactionIdempotency(this.repository);

  Future<Either<Failure, bool>> call(String idempotencyKey) async {
    try {
      final transaction = await repository.getTransactionByIdempotencyKey(idempotencyKey);
      if (transaction!= null) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on DatabaseException catch (e) {
      return Left(InvalidDataFailure('Error de base de datos: ${e.message}'));
    } on Exception catch (e) {
      return Left(GenericFailure('Error inesperado: ${e.toString()}'));
    }
  }
}

// === ARCHIVO: lib/data/models/transaction_model.dart ===
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'transaction_model.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionModel extends Table with EquatableMixin {
  @override
  Set<Column> get columns => {id, amount, recipient, timestamp, syncStatus, idempotencyKey};

  @primaryKey
  final id = text().clientDefault(() => const Uuid().v4());
  final amount = real();
  final recipient = text();
  final timestamp = integer();
  final syncStatus = text();
  final idempotencyKey = text();

  @override
  List<Object?> get props => [id, amount, recipient, timestamp, syncStatus, idempotencyKey];
}

class Transaction extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4());
  RealColumn get amount => real();
  TextColumn get recipient => text();
  IntegerColumn get timestamp => integer();
  TextColumn get syncStatus => text();
  @override
  Set<Column> get columns => {id, amount, recipient, timestamp, syncStatus};
}

// === ARCHIVO: lib/data/datasources/local/transaction_local_datasource.dart ===
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/data/models/transaction_model.dart';
import 'package:payment_app/data/datasources/local/database_helper.dart';

abstract class TransactionLocalDatasource {
  Future<Either<Failure, Unit>> saveTransaction(TransactionModel transaction);
  Future<Either<Failure, List<TransactionModel>>> getPendingTransactions();
  Future<Either<Failure, Unit>> updateTransactionSyncStatus(TransactionModel transaction);
  Future<Either<Failure, bool>> checkTransactionIdempotency(String idempotencyKey);
}

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {
  final DatabaseHelper databaseHelper;

  TransactionLocalDatasourceImpl(this.databaseHelper);

  @override
  Future<Either<Failure, Unit>> saveTransaction(TransactionModel transaction) async {
    try {
      await databaseHelper.database.into(transactionModel).insert(transaction);
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to save transaction'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getPendingTransactions() async {
    try {
      final transactions = await databaseHelper.database.select(transactionModel).where((tbl) => tbl.syncStatus.equals('pending')).get();
      return Right(transactions);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get pending transactions'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTransactionSyncStatus(TransactionModel transaction) async {
    try {
      await databaseHelper.database.update(transactionModel).replace(transaction.copyWith(syncStatus: 'synced'));
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update transaction sync status'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTransactionIdempotency(String idempotencyKey) async {
    try {
      final transaction = await databaseHelper.database.select(transactionModel).where((tbl) => tbl.idempotencyKey.equals(idempotencyKey)).getSingleOrNull();
      return Right(transaction!= null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to check transaction idempotency'));
    }
  }
}

// === ARCHIVO: lib/data/datasources/local/database_helper.dart ===
import 'package:drift/drift.dart';
import 'package:drift/native/native_database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:payment_app/data/models/transaction_model.dart';

class DatabaseHelper {
  late Database database;

  DatabaseHelper() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'transactions.db');
    database = NativeDatabase(File(path));
  }
}

// === ARCHIVO: lib/data/datasources/remote/transaction_remote_datasource.dart ===
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/core/utils/idempotency_generator.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

class TransactionRemoteDataSource {
  final Dio _dio;
  final ConnectivityService _connectivityService;
  final IdempotencyGenerator _idempotencyGenerator;

  TransactionRemoteDataSource(this._dio, this._connectivityService, this._idempotencyGenerator);

  Future<Either<Failure, void>> sendTransaction(TransactionEntity transaction) async {
    if (!await _connectivityService.isConnected()) {
      return Left(ConnectionFailure('No internet connection'));
    }

    final idempotencyKey = _idempotencyGenerator.generate();
    try {
      final response = await _dio.post(
        AppConstants.syncEndpoint,
        data: transaction.toJson(),
        options: Options(
          headers: {
            'Content-Type': AppConstants.contentTypeJson,
            'Idempotency-Key': idempotencyKey,
          }
        },
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure('Server error'));
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Left(TimeoutFailure('Connection timeout'));
      } else {
        return Left(ServerFailure('Server error'));
      }
    }
  }
}

// === ARCHIVO: lib/data/repositories/transaction_repository_impl.dart ===
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource _localDataSource;
  final TransactionRemoteDataSource _remoteDataSource;

  TransactionRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<Failure, void>> saveTransactionLocally(TransactionEntity transaction) async {
    // Implementar la lógica para guardar la transacción localmente
    return Right(null);
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getPendingTransactions() async {
    // Implementar la lógica para obtener las transacciones pendientes
    return Right([]);
  }

  @override
  Future<Either<Failure, void>> syncPendingTransactions() async {
    // Implementar la lógica para sincronizar las transacciones pendientes
    return Right(null);
  }
}

// === ARCHIVO: android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.payment_app">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>

// === ARCHIVO: lib/presentation/blocs/connectivity/connectivity_bloc.dart ===
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/core/utils/idempotency_generator.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions.dart';
import 'package:payment_app/domain/usecases/check_transaction_idempotency.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/lib/core/constants/app_constants.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;
  final GetPendingTransactions _getPendingTransactions;
  final SyncPendingTransactions _syncPendingTransactions;
  final CheckTransactionIdempotency _checkTransactionIdempotency;
  final TransactionRepository _transactionRepository;
  final IdempotencyGenerator _idempotencyGenerator;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityBloc({
    required ConnectivityService connectivityService,
    required GetPendingTransactions getPendingTransactions,
    required SyncPendingTransactions syncPendingTransactions,
    required CheckTransactionIdempotency checkTransactionIdempotency,
    required TransactionRepository transactionRepository,
    required IdempotencyGenerator idempotencyGenerator,
  })  : _connectivityService = connectivityService,
        _getPendingTransactions = getPendingTransactions,
        _syncPendingTransactions = syncPendingTransactions,
        _checkTransactionIdempotency = checkTransactionIdempotency,
        _transactionRepository = transactionRepository,
        _idempotencyGenerator = idempotencyGenerator,
        super(ConnectivityInitial()) {
    _connectivitySubscription = _connectivityService.connectivityStream.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        add(ConnectivityLost());
      } else {
        add(ConnectivityGained());
      }
    });
  }

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ConnectivityGained) {
      yield* _handleConnectivityGained();
    } else if (event is ConnectivityLost) {
      yield ConnectivityOffline();
    }
  }

  Stream<ConnectivityState> _handleConnectivityGained() async* {
    yield ConnectivityChecking();
    final pendingTransactions = await _getPendingTransactions.execute();
    if (pendingTransactions.isRight()) {
      final transactions = pendingTransactions.getOrElse(() => []);
      for (final transaction in transactions) {
        final idempotencyCheck = await _checkTransactionIdempotency.execute(transaction.id);
        if (idempotencyCheck.isRight()) {
          await _syncPendingTransactions.execute(transaction);
        }
      }
    }
    yield ConnectivityOnline();
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}

// === ARCHIVO: lib/presentation/blocs/connectivity/connectivity_event.dart ===
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

// === ARCHIVO: lib/presentation/blocs/connectivity/connectivity_state.dart ===
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

// === ARCHIVO: lib/presentation/blocs/transaction/transaction_bloc.dart ===
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/usecases/save_transaction_locally.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions.dart';
import 'package:payment_app/domain/usecases/check_transaction_idempotency.dart';
import 'package:payment_app/core/utils/idempotency_generator.dart';
import 'package:payment_app/core/network/connectivity_service.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final SaveTransactionLocally saveTransactionLocally;
  final SyncPendingTransactions syncPendingTransactions;
  final GetPendingTransactions getPendingTransactions;
  final CheckTransactionIdempotency checkTransactionIdempotency;
  final ConnectivityService connectivityService;
  final IdempotencyGenerator idempotencyGenerator;

  TransactionBloc({
    required this.saveTransactionLocally,
    required this.syncPendingTransactions,
    required this.getPendingTransactions,
    required this.checkTransactionIdempotency,
    required this.connectivityService,
    required this.idempotencyGenerator,
  }) : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is SaveTransactionEvent) {
      yield* _mapSaveTransactionEventToState(event);
    } else if (event is SyncTransactionsEvent) {
      yield* _mapSyncTransactionsEventToState();
    } else if (event is GetTransactionsEvent) {
      yield* _mapGetTransactionsEventToState();
    } else if (event is CheckIdempotencyEvent) {
      yield* _mapCheckIdempotencyEventToState(event);
    }
  }

  Stream<TransactionState> _mapSaveTransactionEventToState(SaveTransactionEvent event) async* {
    final idempotencyKey = idempotencyGenerator.generateIdempotencyKey();
    final result = await saveTransactionLocally(event.transaction, idempotencyKey);
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (success) => TransactionSaved(transaction: event.transaction),
    );
  }

  Stream<TransactionState> _mapSyncTransactionsEventToState() async* {
    if (!connectivityService.isConnected) {
      yield TransactionError(message: 'No hay conexión a Internet.');
      return;
    }

    final result = await syncPendingTransactions();
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (success) => TransactionsSynced(transactions: success),
    );
  }

  Stream<TransactionState> _mapGetTransactionsEventToState() async* {
    final result = await getPendingTransactions();
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (transactions) => TransactionsLoaded(transactions: transactions),
    );
  }

  Stream<TransactionState> _mapCheckIdempotencyEventToState(CheckIdempotencyEvent event) async* {
    final result = await checkTransactionIdempotency(event.idempotencyKey);
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (isIdempotent) => IdempotencyChecked(isIdempotent: isIdempotent),
    );
  }
}

// === ARCHIVO: lib/presentation/blocs/transaction/transaction_event.dart ===
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class SaveTransactionEvent extends TransactionEvent {
  final TransactionEntity transaction;

  const SaveTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class SyncTransactionsEvent extends TransactionEvent {
  const SyncTransactionsEvent();
}

class GetTransactionsEvent extends TransactionEvent {
  const GetTransactionsEvent();
}

class CheckIdempotencyEvent extends TransactionEvent {
  final String idempotencyKey;

  const CheckIdempotencyEvent(this.idempotencyKey);

  @override
  List<Object> get props => [idempotencyKey];
}

// === ARCHIVO: lib/presentation/blocs/transaction/transaction_state.dart ===
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionSaved extends TransactionState {
  final TransactionEntity transaction;

  const TransactionSaved({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class TransactionsSynced extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionsSynced({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionsLoaded extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object> get props => [message];
}

class IdempotencyChecked extends TransactionState {
  final bool isIdempotent;

  const IdempotencyChecked({required this.isIdempotent});

  @override
  List<Object> get props => [isIdempotent];
}

// === ARCHIVO: lib/presentation/screens/payment_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/widgets/offline_banner.dart';
import 'package:payment_app/presentation/widgets/transaction_card.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Pago'),
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Transacción realizada con éxito')),
            );
          } else if (state is TransactionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error en la transacción: ${state.failure.message}')),
            );
          }
        },
        child: Column(
          children: [
            OfflineBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Monto'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        context.read<TransactionBloc>().add(TransactionAmountChanged(double.tryParse(value)?? 0));
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Destinatario'),
                      onChanged: (value) {
                        context.read<TransactionBloc>().add(TransactionRecipientChanged(value));
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TransactionBloc>().add(TransactionSubmitted());
                      },
                      child: Text('Realizar Pago'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/screens/transaction_history_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_state.dart';
import 'package:payment_app/presentation/widgets/transaction_card.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Transacciones'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(transaction: state.transactions[index]);
              },
            );
          } else if (state is TransactionFailure) {
            return Center(child: Text('Error: ${state.failure.message}'));
          }
          return Center(child: Text('No hay transacciones'));
        },
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/widgets/transaction_card.dart ===
import 'package:flutter/material.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;

  TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monto: ${transaction.amount}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Destinatario: ${transaction.recipient}', style: TextStyle(fontSize: 16)),
            Text('Fecha: ${transaction.timestamp.toLocal()}', style: TextStyle(fontSize: 14)),
            Text('Estado de sincronización: ${transaction.syncStatus.name}', style: TextStyle(fontSize: 14, color: transaction.syncStatus == SyncStatus.synced? Colors.green : Colors.red)),
          ],
        ),
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/widgets/offline_banner.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/constants/app_constants.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/presentation/blocs/connectivity/connectivity_bloc.dart';

class OfflineBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityOffline) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.redAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.offline_bolt, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  AppConstants.offlineModeMessage,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

// === ARCHIVO: test/unit/usecases/save_transaction_locally_test.dart ===
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/usecases/save_transaction_locally.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';

import 'mocks/mock_transaction_repository.dart';

@GenerateMocks([TransactionRepositoryImpl])
void main() {
  late MockTransactionRepositoryImpl repository;
  late SaveTransactionLocally usecase;

  setUp(() {
    repository = MockTransactionRepositoryImpl();
    usecase = SaveTransactionLocally(repository);
  });

  final tTransactionEntity = TransactionEntity(
    id: '1',
    amount: 100.0,
    recipient: 'Recipient Name',
    timestamp: DateTime.now().millisecondsSinceEpoch,
    syncStatus: 'pending',
    idempotencyKey: 'idempotency-key-123',
  );

  test('should save transaction locally when called', () async {
    when(repository.saveTransactionLocally(tTransactionEntity))
       .thenAnswer((_) async => Right(unit));

    final result = await usecase(tTransactionEntity);

    verify(repository.saveTransactionLocally(tTransactionEntity));
    expect(result, Right(unit));
  });

  test('should return a Failure when the repository fails', () async {
    when(repository.saveTransactionLocally(tTransactionEntity))
       .thenAnswer((_) async => Left(DatabaseException('Database error')));

    final result = await usecase(tTransactionEntity);

    verify(repository.saveTransactionLocally(tTransactionEntity));
    expect(result, Left(isA<DatabaseException>()));
  });
}

// === ARCHIVO: test/unit/usecases/sync_pending_transactions_test.dart ===
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';

import 'mocks/mock_transaction_repository.dart';

@GenerateMocks([TransactionRepositoryImpl])
void main() {
  late MockTransactionRepositoryImpl repository;
  late SyncPendingTransactions usecase;

  setUp(() {
    repository = MockTransactionRepositoryImpl();
    usecase = SyncPendingTransactions(repository);
  });

  test('should sync pending transactions when called', () async {
    when(repository.syncPendingTransactions())
       .thenAnswer((_) async => Right(unit));

    final result = await usecase();

    verify(repository.syncPendingTransactions());
    expect(result, Right(unit));
  });

  test('should return a Failure when the repository fails', () async {
    when(repository.syncPendingTransactions())
       .thenAnswer((_) async => Left(ConnectionFailure('Connection error')));

    final result = await usecase();

    verify(repository.syncPendingTransactions());
    expect(result, Left(isA<ConnectionFailure>()));
  });
}

// === ARCHIVO: test/unit/repositories/transaction_repository_impl_test.dart ===
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/data/models/transaction_model.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';

import 'mocks/mock_transaction_local_datasource.dart';
import 'mocks/mock_transaction_remote_datasource.dart';

@GenerateMocks([TransactionLocalDatasource, TransactionRemoteDatasource])
void main() {
  late MockTransactionLocalDatasource localDatasource;
  late MockTransactionRemoteDatasource remoteDatasource;
  late TransactionRepositoryImpl repository;

  setUp(() {
    localDatasource = MockTransactionLocalDatasource();
    remoteDatasource = MockTransactionRemoteDatasource();
    repository = TransactionRepositoryImpl(localDatasource, remoteDatasource);
  });

  final tTransactionModel = TransactionModel(
    id: '1',
    amount: 100.0,
    recipient: 'Recipient Name',
    timestamp: DateTime.now().millisecondsSinceEpoch,
    syncStatus: 'pending',
    idempotencyKey: 'idempotency-key-123',
  );

  test('should save transaction locally when called', () async {
    when(localDatasource.saveTransactionLocally(tTransactionModel))
       .thenAnswer((_) async => Right(unit));

    final result = await repository.saveTransactionLocally(tTransactionModel);

    verify(localDatasource.saveTransactionLocally(tTransactionModel));
    expect(result, Right(unit));
  });

  test('should return a Failure when the local datasource fails', () async {
    when(localDatasource.saveTransactionLocally(tTransactionModel))
       .thenAnswer((_) async => Left(DatabaseException('Database error')));

    final result = await repository.saveTransactionLocally(tTransactionModel);

    verify(localDatasource.saveTransactionLocally(tTransactionModel));
    expect(result, Left(isA<DatabaseException>()));
  });

  test('should sync pending transactions when called', () async {
    when(localDatasource.getPendingTransactions())
       .thenAnswer((_) async => [tTransactionModel]);
    when(remoteDatasource.syncTransaction(tTransactionModel))
       .thenAnswer((_) async => Right(unit));
    when(localDatasource.updateTransactionSyncStatus(tTransactionModel, 'synced'))
       .thenAnswer((_) async => Right(unit));

    final result = await repository.syncPendingTransactions();

    verify(localDatasource.getPendingTransactions());
    verify(remoteDatasource.syncTransaction(tTransactionModel));
    verify(localDatasource.updateTransactionSyncStatus(tTransactionModel, 'synced'));
    expect(result, Right(unit));
  });

  test('should return a Failure when the remote datasource fails', () async {
    when(localDatasource.getPendingTransactions())
       .thenAnswer((_) async => [tTransactionModel]);
    when(remoteDatasource.syncTransaction(tTransactionModel))
       .thenAnswer((_) async => Left(ConnectionFailure('Connection error')));

    final result = await repository.syncPendingTransactions();

    verify(localDatasource.getPendingTransactions());
    verify(remoteDatasource.syncTransaction(tTransactionModel));
    expect(result, Left(isA<ConnectionFailure>()));
  });
}

// === ARCHIVO: test/mocks/mock_transaction_remote_datasource.dart ===
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:payment_app/data/models/transaction_model.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late MockTransactionRemoteDatasource mockTransactionRemoteDatasource;

  setUp(() {
    mockDio = MockDio();
    mockTransactionRemoteDatasource = MockTransactionRemoteDatasource(mockDio);
  });

  group('Mock Transaction Remote Datasource Tests', () {
    test('should return TransactionModel when the response code is 200', () async {
      // Arrange
      final tTransactionModel = TransactionModel(id: '1', amount: 100.0, recipient: 'Recipient', timestamp: DateTime.now().millisecondsSinceEpoch, syncStatus: 'synced');
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer((_) async => Response(statusCode: 200, data: tTransactionModel.toJson()));
      // Act
      final result = await mockTransactionRemoteDatasource.sendTransaction(tTransactionModel);
      // Assert
      verify(mockDio.post(any, data: anyNamed('data'))).called(1);
      expect(result, Right(tTransactionModel));
    });

    test('should return ServerFailure when the response code is 400', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer((_) async => Response(statusCode: 400));
      // Act
      final result = await mockTransactionRemoteDatasource.sendTransaction(TransactionModel());
      // Assert
      verify(mockDio.post(any, data: anyNamed('data'))).called(1);
      expect(result, Left(ServerFailure('Server Failure')));n    });

    test('should return ConnectionFailure when Dio throws DioError with type CONNECT_TIMEOUT', () async {
      // Arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(DioError(type: DioErrorType.connectTimeout));
      // Act
      final result = await mockTransactionRemoteDatasource.sendTransaction(TransactionModel());
      // Assert
      verify(mockDio.post(any, data: anyNamed('data'))).called(1);
      expect(result, Left(ConnectionFailure('Connection Failure')));n    });
  });
}

class MockTransactionRemoteDatasource extends Mock implements TransactionRemoteDatasource {}
```
