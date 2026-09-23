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