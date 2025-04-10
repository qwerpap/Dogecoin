import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.title,
    this.showDivider = false,
    this.isSwitchOn = false, // Add a parameter to control the switch state
    required this.onSwitchChanged, // Callback for when the switch is toggled
  });

  final String title;
  final bool showDivider;
  final bool isSwitchOn; // To store the switch state
  final ValueChanged<bool>
  onSwitchChanged; // Callback to handle switch state change

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              CupertinoSwitch(
                value: isSwitchOn,
                onChanged: onSwitchChanged, // Update the state when switched
              ),
            ],
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Divider(height: 0.33, color: Colors.black12),
          ),
      ],
    );
  }
}
