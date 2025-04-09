import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback? onPressed;
  final ButtonStyle activeStyle;
  final ButtonStyle disabledStyle;
  final TextStyle? textStyle;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.enabled,
    required this.onPressed,
    required this.activeStyle,
    required this.disabledStyle,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: 284,
      child: ElevatedButton(
        style: enabled ? activeStyle : disabledStyle,
        onPressed: enabled ? onPressed : null,
        child: Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
