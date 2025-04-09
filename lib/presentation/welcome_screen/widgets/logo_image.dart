import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Image.asset(
          'assets/png/logo.png',
          height: height,
          errorBuilder:
              (context, error, stackTrace) => const Icon(
                Icons.error,
                size: 150,
                color: AppColors.secondaryColor,
              ),
        ),
      ),
    );
  }
}
