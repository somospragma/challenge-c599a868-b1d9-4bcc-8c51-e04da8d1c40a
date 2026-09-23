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