import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final TextStyle? textStyle;
  final String text;
  final String? textUnderline;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.textStyle,
    required this.text,
    this.textUnderline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: value ? Colors.white : Colors.grey[400],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: Colors.white,
            checkColor: Colors.blue,
            side: const BorderSide(color: Colors.transparent),
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style:
                      textStyle ??
                      theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.blackTextColor,
                      ),
                ),
                TextSpan(
                  text: textUnderline,
                  style: (textStyle ?? theme.textTheme.bodySmall)?.copyWith(
                    color: AppColors.blackTextColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
