import 'package:connection_notifier/connection_notifier.dart';
import 'package:exhange_rates_flutter/screens/check_connection.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      child: MaterialApp(
          title: 'Open Exchange App',
          theme: ThemeData(
            fontFamily: 'DMSans',
            primaryColor: Color(0xffFFD700),
          ),
          debugShowCheckedModeBanner: false,
          home: MyConnectionState()),
    );
  }
}
