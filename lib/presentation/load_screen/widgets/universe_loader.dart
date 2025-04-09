import 'dart:math';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UniverseLoader extends StatefulWidget {
  const UniverseLoader({super.key});

  @override
  State<UniverseLoader> createState() => _UniverseLoaderState();
}

class _UniverseLoaderState extends State<UniverseLoader>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: AnimatedBuilder(
        animation: _rotationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: CustomPaint(
              painter: RingPainter(),
              child: Center(
                child: AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, _) {
                    return Container(
                      width: 20 * _scaleController.value + 5,
                      height: 20 * _scaleController.value + 5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.loadColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFFFCC00)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final Rect rect = Offset.zero & size;
    const double gapAngle = pi / 4; // оставим прозрачный "зазор"
    const double startAngle = gapAngle;

    canvas.drawArc(
      rect.deflate(4), // немного уменьшить радиус
      startAngle,
      2 * pi - gapAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
