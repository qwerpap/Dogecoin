import 'package:dogecoin/presentation/welcome_screen/widgets/custom_checkbox.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/logo_image.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_action_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
      body: Column(
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
                  'Welcome to Doge Wallet\nManage DOGE quickly,',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  textAlign: TextAlign.center,
                  'Manage DOGE quickly,\nconveniently and safely',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.yellowTextColor,
                  ),
                ),
                const SizedBox(height: 40),
                CustomCheckbox(
                  text: 'I accept ',
                  textUnderline: 'Terms Of Use',
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomActionButton(
                  text: 'New wallet',
                  enabled: _termsAccepted,
                  onPressed: () {
                    Navigator.pushNamed(context, '/new_wallet');
                  },
                  activeStyle: activeButtonStyle,
                  disabledStyle: disableButtonStyle,
                ),
                const SizedBox(height: 15),
                CustomActionButton(
                  text: 'Recover wallet',
                  enabled: _termsAccepted,
                  onPressed: () {
                    Navigator.pushNamed(context, '/recover_wallet');
                  },
                  activeStyle: activeButtonStyle,
                  disabledStyle: disableButtonStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
