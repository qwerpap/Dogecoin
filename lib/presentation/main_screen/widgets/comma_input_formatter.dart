import 'package:flutter/services.dart';

class CommaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Заменяем запятую на точку
    String newText = newValue.text.replaceAll(',', '.');
    return newValue.copyWith(text: newText);
  }
}