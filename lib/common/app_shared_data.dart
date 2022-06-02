import 'package:flutter/material.dart';

class AppSharedData extends ChangeNotifier {
  static AppSharedData instance = AppSharedData();

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  set currentPageIndex(int page) {
    _currentPageIndex = page;
    notifyListeners();
  }
}
