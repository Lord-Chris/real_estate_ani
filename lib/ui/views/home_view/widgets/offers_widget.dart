import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_ani/ui/views/home_view/widgets/greeting_widget.dart';

import '../../../shared/constants/_constants.dart';
import '../../../shared/constants/textstyles.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({
    super.key,
  });

  static final startTime = GreetingWidget.startTime + Durations.short4;

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OfferItem(
              label: "BUY",
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.orange,
              count: 1034,
              shape: BoxShape.circle,
            ),
            Gap(30),
            OfferItem(
              label: "RENT",
              foregroundColor: AppColors.lightBrown,
              backgroundColor: AppColors.white,
              count: 2212,
              shape: BoxShape.rectangle,
            ),
          ],
        ),
      ),
    );
  }
}

class OfferItem extends StatelessWidget {
  final String label;
  final double count;
  final Color backgroundColor;
  final Color foregroundColor;
  final BoxShape shape;

  const OfferItem({
    super.key,
    required this.label,
    required this.count,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Animate(
          delay: OffersWidget.startTime,
          effects: const [
            ScaleEffect(
              duration: Durations.extralong3,
              alignment: Alignment.bottomCenter,
              begin: Offset.zero,
            ),
          ],
          child: Container(
            height: 160,
            width: 160,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: shape,
              color: backgroundColor,
              borderRadius: shape == BoxShape.rectangle
                  ? BorderRadius.circular(15)
                  : null,
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: AppStyles.black14Normal.copyWith(
                    color: foregroundColor,
                  ),
                ),
                const Spacer(),
                Countup(
                  begin: 0,
                  end: count,
                  duration: const Duration(milliseconds: 2700),
                  separator: ' ',
                  style: AppStyles.black35Bold.copyWith(
                    color: foregroundColor,
                  ),
                ),
                Text(
                  "offers",
                  style: AppStyles.black14Normal.copyWith(
                    color: foregroundColor,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
