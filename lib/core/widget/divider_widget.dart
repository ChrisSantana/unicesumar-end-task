import 'package:flutter/material.dart';
import 'package:task_end/core/library/theme_helper.dart';

class DividerWidget extends StatelessWidget {
  final double? width;
  final double height;
  final Color? color;
  final EdgeInsets? padding;
  final bool showWidget;

  const DividerWidget({
    super.key,
    this.width,
    this.height = 1,
    this.color,
    this.padding,
    this.showWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showWidget) return const Offstage();
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: color ?? ThemeHelper.theme.disabledColor.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DividerDashedWidget extends StatelessWidget {
  final double? widthTotal;
  final double height;
  final double dashLength;
  final double dashSpace;
  final Color? color;
  final EdgeInsets? padding;
  final bool showWidget;

  const DividerDashedWidget({
    super.key,
    this.widthTotal,
    this.height = 0.5,
    this.dashLength = 2,
    this.dashSpace = 3,
    this.color,
    this.padding,
    this.showWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showWidget) return const Offstage();
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color ?? ThemeHelper.theme.disabledColor.withOpacity(0.5),
          strokeWidth: height,
          dashLength: dashLength,
          dashSpace: dashSpace,
        ),
        child: SizedBox(
          height: height,
          width: widthTotal ?? MediaQuery.sizeOf(context).width,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  const _DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const double startX = 0.0;
    double currentX = startX;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0.0),
        Offset(currentX + dashLength, 0.0),
        paint,
      );
      currentX += dashLength + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
