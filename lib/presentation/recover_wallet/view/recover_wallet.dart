import 'package:dogecoin/presentation/global_widgets/custom_alert_dialog.dart';
import 'package:dogecoin/presentation/new_wallet/widgets/arrow_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/custom_action_button.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/logo_image.dart';
import 'package:dogecoin/theme/app_colors.dart';

class RecoverWallet extends StatefulWidget {
  const RecoverWallet({super.key});

  @override
  State<RecoverWallet> createState() => _RecoverWalletState();
}

class _RecoverWalletState extends State<RecoverWallet> {
  bool _termsAccepted = false;
  final TextEditingController _phraseController = TextEditingController();
  final String _validPhrase = "TestphraseTestphraseTestphraseTestphrase";

  static ButtonStyle activeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.overlayButtonColor;
      }
      return null;
    }),
  );

  static ButtonStyle disableButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.disableButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    side: const BorderSide(color: AppColors.secondaryColor, width: 0.5),
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.overlayButtonColor;
      }
      return null;
    }),
  );

  static final ButtonStyle pasteButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed)
              ? AppColors.overlayButtonColor
              : null,
    ),
  );

  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      setState(() {
        _phraseController.text = clipboardData.text!;
      });
      _onPhraseChanged(clipboardData.text!);
    }
  }

  void _onPhraseChanged(String text) {
    setState(() {
      _termsAccepted = text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _phraseController.dispose();
    super.dispose();
  }

  //для проверки фразы и перехода
  void _onLoginPressed() {
    if (_phraseController.text == _validPhrase) {
      Navigator.pushNamed(context, '/main');
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Authorization error!',
          message: 'Incorrect mnemonic phrase.\nPlease try again.',
          button: 'Try again',
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
                padding: const EdgeInsets.only(top: 22, bottom: 80),
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
                      'Login in Dogecoin wallet',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      'Log in to your account using\nyour mnemonic phrase',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.yellowTextColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: 326,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter a phrase of 12 words or 24 words',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 326,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _phraseController,
                              maxLines: 4,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Enter mnemonic phrase',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.all(12),
                                border: InputBorder.none,
                              ),
                              onChanged: _onPhraseChanged, // Listen for changes
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: TextButton(
                              onPressed: _pasteFromClipboard,
                              style: pasteButtonStyle,
                              child: Text(
                                'Paste',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      width: 326,
                      child: CustomActionButton(
                        text: 'Login now',
                        enabled: _termsAccepted,
                        onPressed: _onLoginPressed,
                        activeStyle: activeButtonStyle,
                        disabledStyle: disableButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ArrowBack(),
        ],
      ),
    );
  }
}
