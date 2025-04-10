import 'package:flutter/material.dart';
import 'package:dogecoin/theme/app_colors.dart';

class SecretPhraseList extends StatelessWidget {
  final List<String> secretWords;
  final VoidCallback onCopyPressed;
  final ButtonStyle copyButtonStyle;
  final ThemeData theme;

  const SecretPhraseList({
    super.key,
    required this.secretWords,
    required this.onCopyPressed,
    required this.copyButtonStyle,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 326,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 48,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(6, (i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${i + 1}. ${secretWords[i]}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppColors.blackTextColor,
                            ),
                          ),
                        );
                      }),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(6, (i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${i + 7}. ${secretWords[i + 6]}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppColors.blackTextColor,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: TextButton(
            onPressed: onCopyPressed,
            style: copyButtonStyle,
            child: Text('Copy', style: theme.textTheme.titleMedium),
          ),
        ),
      ],
    );
  }
}
