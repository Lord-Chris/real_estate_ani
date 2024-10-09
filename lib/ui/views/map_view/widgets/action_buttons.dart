import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_ani/ui/views/map_view/widgets/map_header.dart';

import '../../../providers/view_provider.dart';
import '../../../shared/constants/_constants.dart';
import '../../../shared/constants/enums.dart';
import '../../../shared/constants/textstyles.dart';
import '../../../shared/widgets/ripple_button.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OverlayPortalController();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(builder: (context) {
          return Column(
            children: [
              OverlayPortal(
                controller: controller,
                overlayChildBuilder: (context) => Positioned(
                  left: 30,
                  bottom: 145,
                  height: 200,
                  width: 200,
                  child: NavigationOptions(controller: controller),
                ),
                child: Animate(
                  delay: MapHeader.startTime,
                  effects: const [
                    ScaleEffect(
                      duration: MapHeader.animTime,
                      begin: Offset.zero,
                    ),
                  ],
                  child: RippleButton(
                    onTap: () async {
                      controller.toggle();
                    },
                    backgroundColor: AppColors.grey.withOpacity(.5),
                    size: const Size.square(45),
                    child: const Icon(
                      Icons.wallet_outlined,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const Gap(7),
              Animate(
                delay: MapHeader.startTime,
                effects: const [
                  ScaleEffect(
                    duration: MapHeader.animTime,
                    begin: Offset.zero,
                  ),
                ],
                child: RippleButton(
                  backgroundColor: AppColors.grey.withOpacity(.5),
                  size: const Size.square(45),
                  child: const Icon(
                    Icons.navigation_outlined,
                    size: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          );
        }),
        Animate(
          delay: MapHeader.startTime,
          effects: const [
            ScaleEffect(
              duration: MapHeader.animTime,
              begin: Offset.zero,
            ),
          ],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                color: AppColors.grey.withOpacity(.5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.list,
                      size: 16,
                      color: AppColors.white,
                    ),
                    const Gap(15),
                    Text(
                      "List of variants",
                      style: AppStyles.black12Normal.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NavigationOptions extends HookWidget {
  const NavigationOptions({
    super.key,
    required this.controller,
  });

  final OverlayPortalController controller;

  @override
  Widget build(BuildContext context) {
    final view = Provider.of<ViewProvider>(context);
    final animController = useAnimationController();
    return Animate(
      controller: animController,
      effects: const [
        ScaleEffect(
          duration: MapHeader.animTime,
          begin: Offset.zero,
          alignment: Alignment.bottomLeft,
        ),
      ],
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            for (int i = 0; i < MapDetailsView.values.length; i++)
              Expanded(
                child: InkWell(
                  onTap: () {
                    switch (i) {
                      case 1:
                        view.setPriceWidth();
                        break;
                      case 3:
                        view.setNoLayerWidth();
                        break;
                      default:
                        break;
                    }
                    animController.reverse().then((_) => controller.toggle());
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                    child: Row(
                      children: [
                        Icon(
                          MapDetailsView.values[i].icon,
                          color: view.mapDetailsView == MapDetailsView.values[i]
                              ? AppColors.orange
                              : AppColors.lightBrown,
                          size: 14,
                        ),
                        const Gap(7),
                        Expanded(
                          child: Text(
                            MapDetailsView.values[i].parsed,
                            style: AppStyles.black14Normal.copyWith(
                              color: view.mapDetailsView ==
                                      MapDetailsView.values[i]
                                  ? AppColors.orange
                                  : AppColors.lightBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
