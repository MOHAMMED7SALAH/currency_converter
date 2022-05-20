import 'package:connection_notifier/connection_notifier.dart';
import 'package:exhange_rates_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyConnectionState extends StatefulWidget {
  const MyConnectionState({Key? key}) : super(key: key);

  @override
  State<MyConnectionState> createState() => _MyConnectionStateState();
}

class _MyConnectionStateState extends State<MyConnectionState> {
  String? connectionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      /// If you want to toggle some widgets based on connection state
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return ;
          print(connected);
        },
        connected:  Home(),
        disconnected: 
        Container(
      // height: double.infinity,
      // width: double.infinity,
      child: Center(child: Lottie.asset('assets/no_mobile_internet.json', fit: BoxFit.cover)),
    ),
      ),
    );
  }
}