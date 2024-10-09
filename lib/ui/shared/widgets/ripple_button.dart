import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../constants/_constants.dart';

class RippleButton extends HookWidget {
  final Color backgroundColor;
  final Color rippleColor;
  final Size? size;
  final Widget child;
  final VoidCallback? onTap;

  const RippleButton({
    super.key,
    required this.backgroundColor,
    this.rippleColor = AppColors.white,
    this.size,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl =
        useAnimationController(duration: const Duration(milliseconds: 200));
    final ctrl2 =
        useAnimationController(duration: const Duration(milliseconds: 200));
    bool phase1Done = false;

    bool hideRipple() =>
        (!phase1Done && ctrl.status == AnimationStatus.dismissed) ||
        (phase1Done && ctrl2.status == AnimationStatus.completed);

    ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        phase1Done = true;
        ctrl2.forward();
      }
    });
    ctrl2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        phase1Done = false;
        ctrl.reset();
        ctrl2.reset();
      }
    });
    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              ctrl.forward();
              onTap!();
            },
      child: SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: backgroundColor),
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: !phase1Done ? ctrl : ctrl2,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SubCircleClipper(
                      color: rippleColor,
                      outerRadius1: hideRipple()
                          ? 0
                          : Tween<double>(begin: 1, end: 0.5)
                              .animate(ctrl)
                              .value,
                      innerRadius1: (!phase1Done
                              ? Tween<double>(begin: 0.2, end: 1)
                              : Tween<double>(begin: 1, end: 0.3))
                          .animate(!phase1Done ? ctrl : ctrl2)
                          .value,
                    ),
                    child: child,
                  );
                },
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: ctrl2,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SubCircleClipper(
                      color: rippleColor,
                      outerRadius1: hideRipple()
                          ? 0
                          : Tween<double>(begin: 0.6, end: 1)
                              .animate(ctrl2)
                              .value,
                      innerRadius1: 0.2,
                    ),
                    child: child,
                  );
                },
              ),
            ),
            Center(child: child),
          ],
        ),
      ),
    );
  }
}

class SubCircleClipper extends CustomPainter {
  final double outerRadius1;
  final double innerRadius1;
  final Color color;

  SubCircleClipper({
    required this.outerRadius1,
    required this.innerRadius1,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * innerRadius1;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 * outerRadius1,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
