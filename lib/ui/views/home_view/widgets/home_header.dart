import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../shared/constants/_constants.dart';
import '../../../shared/constants/textstyles.dart';
import '../../../shared/widgets/app_network_image.dart';

class HomeHeader extends HookWidget {
  const HomeHeader({
    super.key,
  });

  static const startTime = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final size = useState(0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) => size.value = 165);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: Durations.extralong4,
                width: size.value,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Animate(
                  effects: const [
                    FadeEffect(
                      delay: startTime,
                      curve: Curves.ease,
                      begin: 0,
                      duration: Durations.extralong1,
                    ),
                  ],
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: AppColors.lightBrown,
                        size: 14,
                      ),
                      const Gap(5),
                      Text(
                        "Saint Petersburg",
                        style: AppStyles.black12Normal.copyWith(
                          color: AppColors.lightBrown,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Animate(
            effects: const [
              ScaleEffect(
                alignment: Alignment.bottomCenter,
                begin: Offset.zero,
                duration: startTime,
                curve: Curves.fastOutSlowIn,
              ),
            ],
            child: const AppNetworkImage(
              isCircular: true,
              url: AppConstants.profileImage,
              size: Size.square(40),
            ),
          ),
        ],
      ),
    );
  }
}
