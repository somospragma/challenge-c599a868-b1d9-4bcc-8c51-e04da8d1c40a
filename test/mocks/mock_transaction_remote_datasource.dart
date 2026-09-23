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