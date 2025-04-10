import 'dart:ui';

import 'package:dogecoin/presentation/global_widgets/custom_alert_dialog.dart';
import 'package:dogecoin/presentation/new_wallet/widgets/secret_phrase_list.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/custom_action_button.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/logo_image.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/arrow_back.dart';

class SecretPhrase extends StatefulWidget {
  const SecretPhrase({super.key});

  @override
  State<SecretPhrase> createState() => _SecretPhraseState();
}

class _SecretPhraseState extends State<SecretPhrase> {
  final List<String> _secretWords = [
    'defy',
    'asthma',
    'local',
    'bleak',
    'monkey',
    'effort',
    'security',
    'surface',
    'actor',
    'obscure',
    'gain',
    'bronze',
  ];

  static final ButtonStyle activeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed)
              ? AppColors.overlayButtonColor
              : null,
    ),
  );

  static final ButtonStyle disableButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.disableButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    side: const BorderSide(color: AppColors.secondaryColor, width: 0.5),
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed)
              ? AppColors.overlayButtonColor
              : null,
    ),
  );

  static final ButtonStyle copyButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed)
              ? AppColors.overlayButtonColor
              : null,
    ),
  );

  Future<void> _copySecretPhrase() async {
    final phrase = _secretWords.join(' ');
    await Clipboard.setData(ClipboardData(text: phrase));

    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomAlertDialog(
          title: 'Mnemonic phrase copied',
          button: 'OK',
          onRetry: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              LogoImage(height: 200),
              Container(
                padding: const EdgeInsets.only(
                  top: 22,
                  bottom: 80,
                  left: 35,
                  right: 35,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                  border: Border(
                    top: BorderSide(width: 1.5, color: AppColors.whiteColor),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create a new wallet',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      'Your secret phrase to\nenter the wallet',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.yellowTextColor,
                      ),
                    ),
                    const SizedBox(height: 13),
                    SecretPhraseList(
                      secretWords: _secretWords,
                      onCopyPressed: _copySecretPhrase,
                      copyButtonStyle: copyButtonStyle,
                      theme: theme,
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      width: 326,
                      child: CustomActionButton(
                        text: 'Search',
                        enabled: true,
                        onPressed: () {
                          Navigator.pushNamed(context, '/finally_screen');
                        },
                        activeStyle: activeButtonStyle,
                        disabledStyle: disableButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ArrowBack(),
        ],
      ),
    );
  }
}
