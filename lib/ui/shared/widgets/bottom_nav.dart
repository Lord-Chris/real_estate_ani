import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../providers/view_provider.dart';
import '../../views/home_view/widgets/houses_widget.dart';
import '../constants/_constants.dart';
import '_widgets.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({
    super.key,
  });

  static final startTime = HousesWidget.startTime + const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: startTime,
      effects: const [
        // MoveEffect(
        //   duration: Duration(seconds: 2),
        //   begin: Offset(1, 500),
        // ),
      ],
      child: Center(
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 60),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.grey900,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavItem(
                icon: Icons.search,
                index: 0,
              ),
              BottomNavItem(
                icon: Icons.message_rounded,
                index: 1,
              ),
              BottomNavItem(
                icon: Icons.home_filled,
                index: 2,
              ),
              BottomNavItem(
                icon: Icons.favorite,
                index: 3,
              ),
              BottomNavItem(
                icon: Icons.person_2,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final int index;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final view = Provider.of<ViewProvider>(context);
    final isSelected = view.viewInt == index;
    return Flexible(
      child: FittedBox(
        child: RippleButton(
          onTap: () => view.setViewInt(index),
          size: const Size.square(48),
          backgroundColor: AppColors.grey900,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.all(isSelected ? 15 : 10),
            margin: isSelected ? EdgeInsets.zero : const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isSelected
                  ? AppColors.black.withOpacity(.5)
                  : AppColors.orange,
            ),
            child: FittedBox(child: Icon(icon, color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
