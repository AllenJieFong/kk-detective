import 'dart:developer';

import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

import '../../../common/model/related_queries_response.dart';
import '../../../common/model/transaction_response_v2.dart';
import '../model/trend_response.dart';

class TrendViewModel with ChangeNotifier {
  TransactionResponseV2? _searchResponse;
  TransactionResponseV2? get searchResponse => _searchResponse;
  set searchResponse(TransactionResponseV2? value) {
    _searchResponse = value;
    notifyListeners();
  }

  List<TrendResponse> _trendList = [];
  List<TrendResponse> get trendList => _trendList;
  set trendList(List<TrendResponse> value) {
    _trendList = value;
    notifyListeners();
  }

  RelatedQueriesResponse? _relatedQueriesResponse;
  RelatedQueriesResponse? get relatedQueriesResponse => _relatedQueriesResponse;
  set relatedQueriesResponse(RelatedQueriesResponse? value) {
    _relatedQueriesResponse = value;
    notifyListeners();
  }

  Future getInterestOverTimeh() async {
    try {
      searchResponse = await APIClient.instance.getInterestOverTime();
    } catch (e) {
      log("error: $e");
    }
  }

  Future getRelatedQuery() async {
    try {
      relatedQueriesResponse = await APIClient.instance.getRelatedQuery();
    } catch (e) {
      log("error: $e");
    }
  }
}
