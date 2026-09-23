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