# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Implementación de modo offline en la app de pagos**.

| | |
|---|---|
| Tema | persistencia local y modo offline |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart / Flutter |
| Patron arquitectonico | clean_architecture_mvvm |
| Tiempo estimado | 10 horas |

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter_bloc 9.1.0
- drift 2.26.0
- drift_dev 2.26.0
- sqlite3_flutter_libs 0.5.32
- path_provider 2.1.5
- path 1.9.1
- connectivity_plus 6.1.4
- dio 5.8.0
- get_it 8.0.3
- dartz 0.10.1
- uuid 4.5.1
- equatable 2.0.7
- build_runner 2.4.15
- mocktail 1.0.4

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `flutter pub get && flutter analyze` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `flutter pub get && flutter analyze` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Diseño del almacén local de datos**: Especificación del diseño del almacén local de datos.
- **Fase 2 — Implementación de la persistencia local**: Código funcional para la persistencia local de transacciones.
- **Fase 3 — Sincronización de transacciones**: Código funcional para la sincronización de transacciones.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `lib/data/datasources/local/database_helper.dart` — El topic pide persistencia: este archivo es el ejercicio.
- [ ] `lib/data/repositories/transaction_repository_impl.dart` — El topic pide persistencia: este archivo es el ejercicio.

## Lo que falta y tenes que completar

### 1. Referencias colgando (10)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `lib/domain/usecases/sync_pending_transactions.dart` — `TransactionRepository.syncTransaction`
      Se invoca `syncTransaction` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/domain/usecases/check_transaction_idempotency.dart` — `TransactionRepository.getTransactionByIdempotencyKey`
      Se invoca `getTransactionByIdempotencyKey` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/data/datasources/remote/transaction_remote_datasource.dart` — `ConnectivityService.isConnected`
      Se invoca `isConnected` sobre `ConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/data/datasources/remote/transaction_remote_datasource.dart` — `IdempotencyGenerator.generate`
      Se invoca `generate` sobre `IdempotencyGenerator`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/data/datasources/remote/transaction_remote_datasource.dart` — `TransactionEntity.toJson`
      Se invoca `toJson` sobre `TransactionEntity`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/presentation/blocs/connectivity/connectivity_bloc.dart` — `GetPendingTransactions.execute`
      Se invoca `execute` sobre `GetPendingTransactions`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/presentation/blocs/connectivity/connectivity_bloc.dart` — `CheckTransactionIdempotency.execute`
      Se invoca `execute` sobre `CheckTransactionIdempotency`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/presentation/blocs/connectivity/connectivity_bloc.dart` — `SyncPendingTransactions.execute`
      Se invoca `execute` sobre `SyncPendingTransactions`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/repositories/transaction_repository_impl_test.dart` — `MockTransactionRemoteDatasource.syncTransaction`
      Se invoca `syncTransaction` sobre `MockTransactionRemoteDatasource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/mocks/mock_transaction_remote_datasource.dart` — `MockTransactionRemoteDatasource.sendTransaction`
      Se invoca `sendTransaction` sobre `MockTransactionRemoteDatasource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (34)

- `pubspec.yaml`
- `lib/main.dart`
- `lib/core/constants/app_constants.dart`
- `lib/core/errors/failures.dart`
- `lib/core/errors/exceptions.dart`
- `lib/core/network/connectivity_service.dart`
- `lib/core/utils/idempotency_generator.dart`
- `lib/domain/entities/transaction_entity.dart`
- `lib/domain/entities/sync_status.dart`
- `lib/domain/repositories/transaction_repository.dart`
- `lib/domain/usecases/save_transaction_locally.dart`
- `lib/domain/usecases/sync_pending_transactions.dart`
- `lib/domain/usecases/get_pending_transactions.dart`
- `lib/domain/usecases/check_transaction_idempotency.dart`
- `lib/data/models/transaction_model.dart`
- `lib/data/datasources/local/transaction_local_datasource.dart`
- `lib/data/datasources/local/database_helper.dart`
- `lib/data/datasources/remote/transaction_remote_datasource.dart`
- `lib/data/repositories/transaction_repository_impl.dart`
- `android/app/src/main/AndroidManifest.xml`
- `lib/presentation/blocs/connectivity/connectivity_bloc.dart`
- `lib/presentation/blocs/connectivity/connectivity_event.dart`
- `lib/presentation/blocs/connectivity/connectivity_state.dart`
- `lib/presentation/blocs/transaction/transaction_bloc.dart`
- `lib/presentation/blocs/transaction/transaction_event.dart`
- `lib/presentation/blocs/transaction/transaction_state.dart`
- `lib/presentation/screens/payment_screen.dart`
- `lib/presentation/screens/transaction_history_screen.dart`
- `lib/presentation/widgets/transaction_card.dart`
- `lib/presentation/widgets/offline_banner.dart`
- `test/unit/usecases/save_transaction_locally_test.dart`
- `test/unit/usecases/sync_pending_transactions_test.dart`
- `test/unit/repositories/transaction_repository_impl_test.dart`
- `test/mocks/mock_transaction_remote_datasource.dart`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `lib/core/constants`
- `lib/core/errors`
- `lib/core/network`
- `lib/core/utils`
- `lib/data/datasources/local`
- `lib/data/datasources/remote`
- `lib/data/models`
- `lib/data/repositories`
- `lib/domain/entities`
- `lib/domain/repositories`
- `lib/domain/usecases`
- `lib/presentation/blocs/connectivity`
- `lib/presentation/blocs/transaction`
- `lib/presentation/screens`
- `lib/presentation/widgets`

## Verificacion

```bash
flutter pub get && flutter analyze
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **clean_architecture_mvvm**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior
- Brecha que el reto ataca: Maneja estado y flujos asincronicos con persistencia local y sincronizacion posterior
- Mision: Soportar operacion sin conexion en la app de pagos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
