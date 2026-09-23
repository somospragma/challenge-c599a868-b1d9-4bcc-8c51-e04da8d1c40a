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