import 'package:flutter/material.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'dart:ui';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String button;
  final VoidCallback onRetry;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    this.message,
    required this.onRetry,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
              child: Container(color: Colors.transparent),
            ),
          ),

          Center(
            child: IntrinsicWidth(
              child: AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 16),
                contentPadding: EdgeInsets.zero,
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      (message == null)
                          ? SizedBox()
                          : Text(
                            message.toString(),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: onRetry,
                        child: Text(
                          button,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.blueTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
