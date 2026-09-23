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