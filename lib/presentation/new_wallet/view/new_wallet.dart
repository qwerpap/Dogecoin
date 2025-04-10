import 'package:dogecoin/presentation/welcome_screen/widgets/custom_action_button.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/logo_image.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../welcome_screen/widgets/custom_checkbox.dart';
import '../widgets/arrow_back.dart';

class NewWallet extends StatefulWidget {
  const NewWallet({super.key});

  @override
  State<NewWallet> createState() => _NewWalletState();
}

class _NewWalletState extends State<NewWallet> {
  bool _termsAccepted = false;

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
    overlayColor: AppColors.overlayButtonColor,
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.overlayButtonColor;
      }
      return null;
    }),
  );

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
                      'Create a new wallet',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      'The secret phrase is \nthe access key to your \nwallet, save it in a safe\n place',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.yellowTextColor,
                      ),
                    ),
                    const SizedBox(height: 64),
                    CustomCheckbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                      },
                      text: 'I have saved the secret phrase in a safe place',
                    ),
                    const SizedBox(height: 27),
                    CustomActionButton(
                      text: 'Continue',
                      enabled: _termsAccepted,
                      onPressed: () {
                        Navigator.pushNamed(context, '/secret_phrase');
                      },
                      activeStyle: activeButtonStyle,
                      disabledStyle: disableButtonStyle,
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
