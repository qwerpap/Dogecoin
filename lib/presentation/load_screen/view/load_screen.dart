import 'dart:async';
import 'package:dogecoin/main.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dogecoin/presentation/load_screen/widgets/universe_loader.dart';
import 'package:dogecoin/theme/app_strings.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  bool _showLoader = true;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();

    // Через 3 секунды — скрываем лоадер и показываем логотип
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showLoader = false;
          _showLogo = true;
        });
      }
    });

    // Через 7 секунд — переход на главный экран
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        _initApp();
      }
    });

    // Инициализация проверки входа
  }

  Future<void> _initApp() async {
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Задержка для имитации загрузки
    final isLoggedIn = await AuthStorage.isLoggedIn();
    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _showLoader
              ? const UniverseLoader()
              : _showLogo
                  ? Center(
                      key: const ValueKey('logo_and_name'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/png/logo.png',
                            height: 305,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.error,
                                  size: 200,
                                  color: AppColors.secondaryColor,
                                ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            AppStrings.dogeWallet,
                            style: theme.textTheme.displayMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(), 
        ),
      ),
    );
  }
}
