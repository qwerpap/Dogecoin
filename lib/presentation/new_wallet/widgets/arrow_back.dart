import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

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
          children: [
            Icon(Icons.arrow_back_ios, size: 16),
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
