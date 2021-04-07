import 'package:flutter/material.dart';

class BottomNaviProvider with ChangeNotifier {
  int bottomNaviIndex = 0;

  void changeBoottomNaviIndex(int index) {
    if (this.bottomNaviIndex != index) {
      this.bottomNaviIndex = index;
      notifyListeners();
    }
  }
}
