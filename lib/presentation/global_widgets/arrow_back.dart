import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      top: 32,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Icon(Icons.arrow_back_ios, size: 16),
            ),
            Text(
              'Back',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.blackTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
