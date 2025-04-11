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
  runApp(const DogecoinApp());
}

class DogecoinApp extends StatelessWidget {
  const DogecoinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/load', // всегда начинаем с экрана загрузки
      routes: {
        '/load': (context) => const LoadScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/new_wallet': (context) => const NewWallet(),
        '/recover_wallet': (context) => const RecoverWallet(),
        '/secret_phrase': (context) => const SecretPhrase(),
        '/finally_screen': (context) => const FinallyScreen(),
        '/main': (context) => const MainScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

class AuthStorage {
  static const _keyIsLoggedIn = 'is_logged_in';

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
  }
}
