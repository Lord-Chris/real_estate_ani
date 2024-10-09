import 'package:flutter/material.dart';

enum MapDetailsView {
  cosyAreas('Cosy areas', Icons.security_outlined),
  price('Price', Icons.wallet),
  infra('Infrastructure', Icons.badge_sharp),
  withoutLayer('Without any layer', Icons.menu_sharp);

  const MapDetailsView(this.parsed, this.icon);
  final String parsed;
  final IconData icon;
}
