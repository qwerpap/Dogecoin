import 'dart:ui';
import 'package:dogecoin/presentation/main_screen/widgets/custom_app_bar.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/rounded_container_card.dart';
import '../widgets/settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationsEnabled = true;
  bool _isSoundEffects = false;
  bool _isVibrationFeedback = false;

  void _onSwitchChanged(String title, bool value) {
    setState(() {
      switch (title) {
        case 'Notifications':
          _isNotificationsEnabled = value;
          break;
        case 'Sound Effects':
          _isSoundEffects = value;
          break;
        case 'Vibration Feedback':
          _isVibrationFeedback = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle saveChangeButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor.withOpacity(0.3),
      foregroundColor: AppColors.blackTextColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      side: const BorderSide(color: AppColors.borderButtonColor),
      elevation: 0,
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (states) =>
            states.contains(MaterialState.pressed)
                ? AppColors.overlayButtonColor
                : null,
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primaryColor;
        }
        return AppColors.activeButtonStyle;
      }),
    );

    final ButtonStyle homeButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: AppColors.blackTextColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 0,
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (states) =>
            states.contains(MaterialState.pressed)
                ? AppColors.overlayButtonColor
                : null,
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.activeButtonStyle;
        }
        return Colors.transparent;
      }),
    );

    final ButtonStyle deleteButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: AppColors.redTextColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 0,
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (states) =>
            states.contains(MaterialState.pressed)
                ? AppColors.overlayButtonColor
                : null,
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primaryColor;
        }
        return Colors.transparent;
      }),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            CustomAppBar(
              containerColor: AppColors.activeSettingIcon,
              iconColor: AppColors.whiteColor,
            ),
            SizedBox(height: 34),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Transaction settings:'),
            ),
            SizedBox(height: 14),
            RoundedContainerCard(
              children: [
                SettingsCard(
                  title: 'Notifications',
                  showDivider: true,
                  isSwitchOn: _isNotificationsEnabled,
                  onSwitchChanged: (bool value) {
                    _onSwitchChanged('Notifications', value);
                  },
                ),
                SettingsCard(
                  title: 'Sound Effects',
                  showDivider: true,
                  isSwitchOn: _isSoundEffects,
                  onSwitchChanged: (bool value) {
                    _onSwitchChanged('Sound Effects', value);
                  },
                ),
                SettingsCard(
                  title: 'Vibration Feedback',
                  showDivider: true,
                  isSwitchOn: _isVibrationFeedback,
                  onSwitchChanged: (bool value) {
                    _onSwitchChanged('Vibration Feedback', value);
                  },
                ),
              ],
            ),
            SizedBox(height: 22),
            SizedBox(
              height: 58,
              width: double.infinity,
              child: ElevatedButton(
                style: saveChangeButtonStyle,
                onPressed: () {
                  //save the settings logic
                },
                child: Text(
                  'Save changes',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: homeButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
              child: Text('Back home'),
            ),
            Spacer(),
            ElevatedButton(
              style: deleteButtonStyle,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 0.8,
                                sigmaY: 0.8,
                              ),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                          Center(
                            child: IntrinsicWidth(
                              child: Container(
                                width: 350,
                                child: AlertDialog(
                                  insetPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  content: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Delete Account',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.copyWith(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'This action requires confirmation\nDo you want to delete your account?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(color: Colors.black26),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color:
                                                            AppColors
                                                                .blueTextColor,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 1,
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/welcome',
                                                  );
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color:
                                                            AppColors
                                                                .redTextColor,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.redTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
