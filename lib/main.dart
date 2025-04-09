import 'package:dogecoin/presentation/load_screen/view/load_screen.dart';
import 'package:dogecoin/presentation/new_wallet/view/new_wallet.dart';
import 'package:dogecoin/presentation/recover_wallet/view/recover_wallet.dart';
import 'package:dogecoin/presentation/welcome_screen/view/welcome_screen.dart';
import 'package:dogecoin/presentation/registration_screen/view/registration_scree.dart';
import 'package:dogecoin/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DogecoinApp());
}

class DogecoinApp extends StatelessWidget {
  const DogecoinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/welcome',
      routes: {
        '/load': (context) => LoadScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/register': (context) => RegistrationScreen(),
        '/new_wallet': (context) => NewWallet(),
        '/recover_wallet': (context) => RecoverWallet(),
      },
    );
  }
}
