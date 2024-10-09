import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_ani/core/extensions/context_extenstion.dart';

import '../../../shared/constants/_constants.dart';
import '../../../shared/constants/textstyles.dart';
import 'offers_widget.dart';

class HousesWidget extends StatelessWidget {
  const HousesWidget({
    super.key,
  });

  static final startTime = OffersWidget.startTime + Durations.extralong4;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Animate(
      delay: startTime,
      effects: const [
        MoveEffect(
          duration: Durations.extralong4,
          begin: Offset(1, 500),
        ),
      ],
      child: Container(
        width: double.infinity,
        height: context.screenSize.height * .7,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              child: HouseItem(
                height: 200,
                image: AppImgAssets.house,
                width: double.infinity,
                address: "Gladkova St., 25",
              ),
            ),
            const Gap(10),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 310,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: HouseItem(
                        image: AppImgAssets.house,
                        width: size.width * .5,
                        address: "Gladkova St., 25",
                        style: AppStyles.black10Normal,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: HouseItem(
                              image: AppImgAssets.house,
                              style: AppStyles.black10Normal,
                              address: "Gladkova St., 25",
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: HouseItem(
                              image: AppImgAssets.house,
                              style: AppStyles.black10Normal,
                              address: "Gladkova St., 25",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HouseItem extends HookWidget {
  final double? height;
  final double? width;
  final String image;
  final String address;
  final TextStyle? style;
  const HouseItem({
    super.key,
    required this.image,
    required this.address,
    this.height,
    this.width,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final size = useState(0.0);
    return Container(
      height: height ?? double.maxFinite,
      width: width ?? double.maxFinite,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Animate(
            onComplete: (controller) => size.value = context.screenSize.width,
            delay: HousesWidget.startTime + Durations.extralong4,
            effects: const [
              ScaleEffect(
                alignment: Alignment.bottomCenter,
                begin: Offset.zero,
                end: Offset(1, 1),
                duration: Durations.long2,
              ),
            ],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: AnimatedContainer(
                  height: 50,
                  duration: const Duration(milliseconds: 600),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1500),
                          width: size.value,
                          height: double.maxFinite,
                          padding: const EdgeInsets.all(5),
                          child: Animate(
                            delay:
                                HousesWidget.startTime + Durations.extralong4,
                            effects: const [
                              FadeEffect(
                                delay: Duration(milliseconds: 1500),
                                curve: Curves.ease,
                                duration: Duration(seconds: 1),
                              ),
                            ],
                            child: Center(
                              child: Text(
                                address,
                                style: style,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: double.maxFinite,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 10,
                          color: AppColors.lightBrown,
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
