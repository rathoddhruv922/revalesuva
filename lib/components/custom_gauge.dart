import 'dart:math';

import 'package:flutter/material.dart';
import 'package:revalesuva/utils/app_colors.dart';

class GaugePainter extends CustomPainter {
  final double position;

  GaugePainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height;

    // Outer Half Circle (Gradient Arc)
    final Rect arcRect = Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: radius,
    );
    final Paint arcPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.green, Colors.orange, Colors.red],
      ).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    canvas.drawArc(
      arcRect,
      pi,
      pi,
      false,
      arcPaint,
    );

    final double innerCircleRadius = radius - 70;

    // Draw shadow for inner circle first
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // Draw shadow slightly offset
    final Rect shadowRect = Rect.fromCircle(
      center: Offset(centerX, centerY - 5),
      radius: innerCircleRadius,
    );

    canvas.drawArc(
      shadowRect,
      pi,
      pi,
      true,
      shadowPaint,
    );

    // Inner Grey Half Circle - Smaller Radius
    final Paint greyCirclePaint = Paint()
      ..color = AppColors.surfaceTertiary
      ..style = PaintingStyle.fill;

    final Rect innerRect = Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: innerCircleRadius,
    );

    canvas.drawArc(
      innerRect,
      pi,
      pi,
      true,
      greyCirclePaint,
    );

    // Draw the numbers along the arc
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    final List<int> numbers = [40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160];

    for (int i = 0; i < numbers.length; i++) {
      final angle = pi + (i * (pi / (numbers.length - 1)));
      final offsetX = centerX + cos(angle) * (radius - 25);
      final offsetY = centerY + sin(angle) * (radius - 25);
      final textSpan = TextSpan(
        text: numbers[i].toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(offsetX - textPainter.width / 2, offsetY - textPainter.height / 2),
      );
    }

    // Calculate the angle for the position
    final double minValue = numbers.first.toDouble();
    final double maxValue = numbers.last.toDouble();
    final double clampedPosition = position.clamp(minValue, maxValue);
    final double valueAngle = pi + ((clampedPosition - minValue) / (maxValue - minValue)) * pi;

    // Arrow dimensions
    final double arrowStartRadius = innerCircleRadius;
    final double arrowEndRadius = radius - 50;
    const double triangleBaseAngle = pi / 35;

    // Calculate arrow points
    final double tipX = centerX + cos(valueAngle) * arrowEndRadius;
    final double tipY = centerY + sin(valueAngle) * arrowEndRadius;
    final double baseLeftX = centerX + cos(valueAngle - triangleBaseAngle) * arrowStartRadius;
    final double baseLeftY = centerY + sin(valueAngle - triangleBaseAngle) * arrowStartRadius;
    final double baseRightX = centerX + cos(valueAngle + triangleBaseAngle) * arrowStartRadius;
    final double baseRightY = centerY + sin(valueAngle + triangleBaseAngle) * arrowStartRadius;

    // Create arrow path
    final Path trianglePath = Path();
    trianglePath.moveTo(tipX, tipY);
    trianglePath.lineTo(baseLeftX, baseLeftY);
    trianglePath.lineTo(baseRightX, baseRightY);
    trianglePath.close();

    // Draw arrow shadow first
    final Paint arrowShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Create shadow path with slight offset
    final Path shadowPath = Path();
    shadowPath.moveTo(tipX + 5, tipY + 2); // Offset shadow down slightly
    shadowPath.lineTo(baseLeftX + 5, baseLeftY + 0);
    shadowPath.lineTo(baseRightX + 5, baseRightY + 0);
    shadowPath.close();

    canvas.drawPath(shadowPath, arrowShadowPaint);

    // Draw the actual arrow
    final Paint trianglePaint = Paint()
      ..color = AppColors.iconGreen
      ..style = PaintingStyle.fill;

    canvas.drawPath(trianglePath, trianglePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
