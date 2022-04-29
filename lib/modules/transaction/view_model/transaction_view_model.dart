import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../common/model/chart_response.dart';
import '../../../network/api_client.dart';

class TransactionViewModel with ChangeNotifier {
  ChartResponse? _transactionResponse;
  ChartResponse? get transactionResponse => _transactionResponse;
  set transactionResponse(ChartResponse? value) {
    _transactionResponse = value;
    notifyListeners();
  }

  Future getTransaction() async {
    try {
      transactionResponse = await APIClient.instance.getTransaction();
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
}
