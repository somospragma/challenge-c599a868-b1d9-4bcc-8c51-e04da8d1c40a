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