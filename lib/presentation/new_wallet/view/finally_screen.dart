import 'package:dogecoin/presentation/welcome_screen/widgets/custom_action_button.dart';
import 'package:dogecoin/presentation/welcome_screen/widgets/logo_image.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinallyScreen extends StatefulWidget {
  const FinallyScreen({super.key});

  @override
  State<FinallyScreen> createState() => _FinallyScreenState();
}

class _FinallyScreenState extends State<FinallyScreen> {

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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                LogoImage(height: 200),
                Container(
                  padding: const EdgeInsets.only(top: 22, bottom: 80),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.darkYellowColor,
                    border: Border(
                      top: BorderSide(width: 1.5, color: AppColors.whiteColor),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Congratulations!',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        textAlign: TextAlign.center,
                        'You have successfully\ncreated a wallet on the\nDogecoin blockchain',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.yellowTextColor,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: 324,
                        child: CustomActionButton(
                          text: 'Run app',
                          enabled: true,
                          onPressed: () {
                            Navigator.pushNamed(context, '/main');
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
          ],
        ),
      ),
    );
  }
}
