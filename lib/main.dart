import 'package:dogecoin/presentation/global_widgets/lifecycle_watcher.dart';
import 'package:dogecoin/presentation/load_screen/view/load_screen.dart';
import 'package:dogecoin/presentation/main_screen/view/main_screen.dart';
import 'package:dogecoin/presentation/new_wallet/view/finally_screen.dart';
import 'package:dogecoin/presentation/new_wallet/view/new_wallet.dart';
import 'package:dogecoin/presentation/new_wallet/view/secret_phrase.dart';
import 'package:dogecoin/presentation/recover_wallet/view/recover_wallet.dart';
import 'package:dogecoin/presentation/settings_screen/view/settings_screen.dart';
import 'package:dogecoin/presentation/welcome_screen/view/welcome_screen.dart';
import 'package:dogecoin/presentation/registration_screen/view/registration_scree.dart';
import 'package:dogecoin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final wasOpenedBefore = prefs.getBool('wasOpenedBefore') ?? false;
  final savedRoute = prefs.getString('last_route');

  String initialRoute;

  if (wasOpenedBefore && savedRoute != null) {
    initialRoute = savedRoute;
  } else {
    initialRoute = '/welcome'; // Или другой стартовый экран
    await prefs.setBool('wasOpenedBefore', true);
  }

  runApp(DogecoinApp(initialRoute: '/load'));
}

class DogecoinApp extends StatelessWidget {
  final String initialRoute;

  const DogecoinApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: initialRoute,
      routes: {
        '/load': (context) => LoadScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/register': (context) => RegistrationScreen(),
        '/new_wallet': (context) => NewWallet(),
        '/recover_wallet': (context) => RecoverWallet(),
        '/secret_phrase': (context) => SecretPhrase(),
        '/finally_screen': (context) => FinallyScreen(),
        '/main': (context) => MainScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}