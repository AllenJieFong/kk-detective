import 'dart:developer';

import 'package:detectivce_dashboard/common/model/related_queries_response.dart';
import 'package:flutter/material.dart';

import '../../../common/model/chart_response.dart';
import '../../../common/model/transaction_response_v2.dart';
import '../../../network/api_client.dart';

class TransactionViewModel with ChangeNotifier {
  TransactionResponseV2? _transactionResponse;
  TransactionResponseV2? get transactionResponse => _transactionResponse;
  set transactionResponse(TransactionResponseV2? value) {
    _transactionResponse = value;
    notifyListeners();
  }

  Future getTransaction() async {
    try {
      transactionResponse = await APIClient.instance.getTransactionV2();
    } catch (e) {
      log("error: $e");
    }
  }

  ChartResponse? _transactionRateResponse;
  ChartResponse? get transactionRateResponse => _transactionRateResponse;
  set transactionRateResponse(ChartResponse? value) {
    _transactionRateResponse = value;
    notifyListeners();
  }

  Future getTransactionRate() async {
    try {
      transactionRateResponse = await APIClient.instance.getTransactionRate();
    } catch (e) {
      log("error: $e");
    }
  }

  ChartResponse? _commonPieResponse;
  ChartResponse? get commonPieResponse => _commonPieResponse;
  set commonPieResponse(ChartResponse? value) {
    _commonPieResponse = value;
    notifyListeners();
  }

  Future getCommonPie() async {
    try {
      commonPieResponse = await APIClient.instance.getCommentPie();
    } catch (e) {
      log("error: $e");
    }
  }

  TransactionResponseV2? _trendResponseV2;
  TransactionResponseV2? get trendResponseV2 => _trendResponseV2;
  set trendResponseV2(TransactionResponseV2? value) {
    _trendResponseV2 = value;
    notifyListeners();
  }
  Future getTransactionV2() async {
    try {
      trendResponseV2 = await APIClient.instance.getTransactionV2();
    } catch (e) {
      log("error: $e");
    }
  }

  RelatedQueriesResponse? _relatedQueriesResponse;
  RelatedQueriesResponse? get relatedQueriesResponse => _relatedQueriesResponse;
  set relatedQueriesResponse(RelatedQueriesResponse? value) {
    _relatedQueriesResponse = value;
    notifyListeners();
  }
  Future getRelatedQuery() async {
    try {
      relatedQueriesResponse = await APIClient.instance.getRelatedQuery();
    } catch (e) {
      log("error: $e");
    }
  }
}
