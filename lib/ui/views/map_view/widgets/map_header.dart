import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../shared/constants/_constants.dart';
import '../../../shared/widgets/_widgets.dart';

class MapHeader extends StatelessWidget {
  const MapHeader({
    super.key,
  });

  static const startTime = Duration.zero;
  static const animTime = Durations.long4;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Animate(
              delay: startTime,
              effects: const [
                ScaleEffect(
                  duration: animTime,
                  begin: Offset.zero,
                ),
              ],
              child: const AppTextField(
                prefix: Icon(Icons.search_rounded),
                initialValue: "Saint Petersburg",
                enabled: false,
              ),
            ),
          ),
          const Gap(10),
          Animate(
            delay: startTime,
            effects: const [
              ScaleEffect(
                duration: animTime,
                begin: Offset.zero,
              ),
            ],
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.settings),
            ),
          )
        ],
      ),
    );
  }
}
