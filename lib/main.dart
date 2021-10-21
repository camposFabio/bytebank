import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard/dashboard.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Saldo(),
        ),
        ChangeNotifierProvider(
          create: (context) => Transferencias(),
        ),
      ],
      child: const BytebankApp(),
    ));

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green.shade900,
            secondary: Colors.blueAccent.shade700,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
            ),
          )),
      home: const Dasboard(),
    );
  }
}
