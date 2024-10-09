import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_ani/ui/providers/view_provider.dart';

import '../../shared/constants/_constants.dart';
import 'widgets/greeting_widget.dart';
import 'widgets/home_header.dart';
import 'widgets/houses_widget.dart';
import 'widgets/offers_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ViewProvider>(builder: (context, view, _) {
        return Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.3, 0.5, 0.7, 1],
                  colors: [
                    AppColors.orange.withOpacity(0.05),
                    AppColors.orange.withOpacity(0.1),
                    AppColors.orange.withOpacity(0.2),
                    AppColors.orange.withOpacity(0.3),
                  ],
                ),
              ),
              child: const SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(15),
                      HomeHeader(),
                      Gap(30),
                      GreetingWidget(),
                      Gap(30),
                      OffersWidget(),
                      Gap(30),
                      HousesWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
