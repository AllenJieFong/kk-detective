import 'dart:developer';

import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

import '../../../common/model/chart_response.dart';
import '../model/trend_response.dart';

class TrendViewModel with ChangeNotifier {
  ChartResponse? _searchResponse;
  ChartResponse? get searchResponse => _searchResponse;
  set searchResponse(ChartResponse? value) {
    _searchResponse = value;
    notifyListeners();
  }

  List<TrendResponse> _trendList = [];
  List<TrendResponse> get trendList => _trendList;
  set trendList(List<TrendResponse> value) {
    _trendList = value;
    notifyListeners();
  }

  Future getSearch() async {
    try {
      searchResponse = await APIClient.instance.getSearch();
    } catch (e) {
      log("@@error: $e");
    }
  }

  Future getTrend() async {
    try {
      trendList = await APIClient.instance.getTrend();
    } catch (e) {
      log("@@error: $e");
    }
  }
}
