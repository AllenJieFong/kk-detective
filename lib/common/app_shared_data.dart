import 'package:flutter/material.dart';

class AppSharedData extends ChangeNotifier {
  static AppSharedData instance = AppSharedData();

  int _currentPaggIndex = 0;
  int get currentPaggIndex => _currentPaggIndex;
  set currentPaggIndex(int page) {
    _currentPaggIndex = page;
    notifyListeners();
  }
}
