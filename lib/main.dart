import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_ani/ui/views/home_view/home_view.dart';
import 'package:real_estate_ani/ui/views/map_view/map_view.dart';
import 'package:real_estate_ani/ui/providers/view_provider.dart';

import 'ui/shared/widgets/bottom_nav.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ViewProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Builder(builder: (context) {
                  final view = Provider.of<ViewProvider>(context);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 2000),
                    reverseDuration: const Duration(milliseconds: 2000),
                    switchInCurve: Curves.decelerate,
                    switchOutCurve: Curves.decelerate,
                    child:
                        view.viewInt == 0 ? const MapView() : const HomeView(),
                  );
                }),
              ),
              const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: BottomNavWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
