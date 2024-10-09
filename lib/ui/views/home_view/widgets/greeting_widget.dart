import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_ani/ui/views/home_view/widgets/home_header.dart';

import '../../../shared/constants/_constants.dart';
import '../../../shared/constants/textstyles.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({
    super.key,
  });

  static final startTime = HomeHeader.startTime + Durations.short4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Animate(
            effects: [
              FadeEffect(
                delay: startTime,
                curve: Curves.ease,
                begin: 0,
                duration: startTime + Durations.long1,
              ),
            ],
            child: Text(
              "Hi, Marina",
              style: AppStyles.black20Normal.copyWith(
                color: AppColors.lightBrown,
              ),
            ),
          ),
          ClipPath(
            child: Animate(
              effects: [
                MoveEffect(
                  delay: startTime,
                  duration: Durations.long2,
                  begin: const Offset(1, 40),
                  end: const Offset(1, 1),
                ),
              ],
              child: Text(
                "Let's select your",
                style: AppStyles.black30Normal,
              ),
            ),
          ),
          ClipPath(
            child: Animate(
              effects: [
                MoveEffect(
                  delay: startTime + Durations.short1,
                  duration: Durations.long2,
                  begin: const Offset(1, 50),
                  end: const Offset(1, 1),
                ),
              ],
              child: Text(
                "perfect place",
                style: AppStyles.black30Normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
