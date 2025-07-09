import 'package:flutter/material.dart';
import 'package:revalesuva/utils/app_colors.dart';

class JigsawClipper extends CustomClipper<Path> {
  final int cols, rows, index;
  final bool isShow;
  final List<int> showPiecesList;

  JigsawClipper({
    required this.cols,
    required this.rows,
    required this.index,
    required this.isShow,
    required this.showPiecesList,
  });

  bool isTopEdge() => index < cols;

  bool isBottomEdge() => index >= (rows - 1) * cols;

  bool isLeftEdge() => index % cols == 0;

  bool isRightEdge() => (index + 1) % cols == 0;

  bool toShow() => isShow;

  @override
  Path getClip(Size size) {
    Path path = Path();
    double notchSize = size.width * 0.20;

    path.moveTo(0, 0);

    // Top Edge
    if (!isTopEdge()) {
      path.lineTo(size.width * 0.5 - notchSize, 0);
      var topIndex = index - cols;
      path.arcToPoint(
        Offset(size.width * 0.5 + notchSize, 0),
        radius: Radius.circular(notchSize),
        clockwise: showPiecesList.contains(topIndex) ? true : false,
      );
    }
    path.lineTo(size.width, 0);

    // Right Edge
    if (!isRightEdge()) {
      path.lineTo(size.width, size.height * 0.5 - notchSize);
      path.arcToPoint(
        Offset(size.width, size.height * 0.5 + notchSize),
        radius: Radius.circular(notchSize),
        clockwise: true,
      );
    }
    path.lineTo(size.width, size.height);

    // Bottom Edge
    if (!isBottomEdge()) {
      path.lineTo(size.width * 0.5 + notchSize, size.height);
      path.arcToPoint(
        Offset(size.width * 0.5 - notchSize, size.height),
        radius: Radius.circular(notchSize),
        clockwise: true,
      );
    }
    path.lineTo(0, size.height);

    // Left Edge
    if (!isLeftEdge()) {
      path.lineTo(0, size.height * 0.5 + notchSize);
      path.arcToPoint(
        Offset(0, size.height * 0.5 - notchSize),
        radius: Radius.circular(notchSize),
        clockwise: showPiecesList.contains(index - 1) ? !isShow : false,
      );
    }
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class JigsawPainter extends CustomPainter {
  final int cols, rows, index;
  final bool isShow;
  final List<int> showPiecesList;

  JigsawPainter({
    required this.cols,
    required this.rows,
    required this.index,
    required this.isShow,
    required this.showPiecesList,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = showPiecesList.contains(index) ? AppColors.borderTertiary : AppColors.borderPrimary
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withValues(alpha: 1); // Transparent background color

    // Then draw the border
    Path path = JigsawClipper(
            cols: cols, rows: rows, index: index, isShow: isShow, showPiecesList: showPiecesList)
        .getClip(size);
    if (isShow) {
      canvas.drawPath(path, fillPaint);
    }
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
