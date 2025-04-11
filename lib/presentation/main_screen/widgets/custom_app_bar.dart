import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.containerColor,
    required this.iconColor, required this.padding,
  });

  final Color containerColor;
  final Color iconColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding:  EdgeInsets.all(padding),
      child: SizedBox(
        height: 88,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/png/logo.png',
              height: 88,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.error,
                    size: 150,
                    color: AppColors.secondaryColor,
                  ),
            ),
            Row(
              children: [
                Container(
                  height: 47,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  decoration: BoxDecoration(color: AppColors.secondaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/png/arrow_up.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '\$',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        '32,54',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '+0.13%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greenTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 17),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Material(
                    color: containerColor,
                    child: InkWell(
                      splashColor: AppColors.borderButtonColor,
                      highlightColor: AppColors.overlayButtonColor.withOpacity(
                        0.15,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                      child: Container(
                        height: 47,
                        width: 47,
                        alignment: Alignment.center,
                        child: Icon(Icons.settings, color: iconColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
