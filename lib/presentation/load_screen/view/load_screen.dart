import 'dart:async';
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

  @override
  void initState() {
    super.initState();

    // Через 3 секунды — показать логотип
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showLoader = false;
      });
    });

    // Через 4 секунды — переход на главный экран
    Timer(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child:
              _showLoader
                  ? const UniverseLoader()
                  : Center(
                    child: Column(
                      key: const ValueKey('logo_and_name'),
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
                  ),
        ),
      ),
    );
  }
}
