import 'package:flutter/material.dart';

import '../shared/constants/enums.dart';

class ViewProvider extends ChangeNotifier {
  int viewInt = 2;
  MapDetailsView mapDetailsView = MapDetailsView.price;

  void setViewInt(int viewInt) {
    this.viewInt = viewInt;
    notifyListeners();
  }

  void setNoLayerWidth() {
    if (mapDetailsView == MapDetailsView.withoutLayer) return;
    mapDetailsView = MapDetailsView.withoutLayer;
    notifyListeners();
  }

  void setPriceWidth() {
    if (mapDetailsView == MapDetailsView.price) return;
    mapDetailsView = MapDetailsView.price;
    notifyListeners();
  }
}
