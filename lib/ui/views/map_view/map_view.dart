import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_ani/ui/providers/view_provider.dart';
import 'package:real_estate_ani/ui/shared/constants/app_colors.dart';
import 'package:real_estate_ani/ui/shared/constants/enums.dart';
import 'package:real_estate_ani/ui/shared/constants/textstyles.dart';

import 'widgets/action_buttons.dart';
import 'widgets/map_header.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ViewProvider>(builder: (context, view, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: FlutterMap(
                options: const MapOptions(
                  interactionOptions: InteractionOptions(
                    enableMultiFingerGestureRace: false,
                    rotationWinGestures: MultiFingerGesture.none,
                  ),
                  initialZoom: 15.3,
                  initialCenter: LatLng(6.5899896, 3.9808723),
                  backgroundColor: AppColors.black,
                ),
                children: [
                  openStreetMapTileLayer,
                  MarkerLayer(
                    rotate: false,
                    markers: [
                      _buildMarker(const LatLng(6.5927984, 3.9822939)),
                      _buildMarker(
                        const LatLng(6.5940793, 3.9789646),
                      ),
                      _buildMarker(
                        const LatLng(6.5958434, 3.9857431),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 100,
              left: 30,
              right: 30,
              child: ActionButtons(),
            ),
            const Positioned(
              top: 25,
              left: 30,
              right: 30,
              child: MapHeader(),
            ),
          ],
        );
      }),
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.real_estate_ani',
        // Use the recommended flutter_map_cancellable_tile_provider package to
        // support the cancellation of loading tiles.
        tileBuilder: _darkModeTileBuilder,
      );

  Widget _darkModeTileBuilder(
    BuildContext context,
    Widget tileWidget,
    TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(
        <double>[
          -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
          -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
          -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
          0, 0, 0, 1, 0, // Alpha channel
        ],
      ),
      child: tileWidget,
    );
  }

  Marker _buildMarker(LatLng latLng) {
    return Marker(
      point: latLng,
      height: 40,
      width: 80,
      alignment: Alignment.centerLeft,
      child: const MarkerItem(),
    );
  }
}

class MarkerItem extends StatelessWidget {
  const MarkerItem({
    super.key,
  });

  static final startTime = MapHeader.startTime +
      MapHeader.animTime +
      const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final view = Provider.of<ViewProvider>(context);
    return Animate(
      delay: startTime,
      effects: const [
        ScaleEffect(
          duration: Durations.long4,
          begin: Offset.zero,
          alignment: Alignment.bottomLeft,
        ),
      ],
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: view.mapDetailsView != MapDetailsView.withoutLayer ? 80 : 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            switchInCurve: Curves.easeIn,
            child: view.mapDetailsView != MapDetailsView.withoutLayer
                ? Text(
                    '13,3 mn P',
                    style: AppStyles.black12Normal.copyWith(
                      color: AppColors.white,
                    ),
                  )
                : const Icon(
                    Icons.panorama_vertical_select_outlined,
                    color: AppColors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
