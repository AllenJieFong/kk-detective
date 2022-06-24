import 'dart:developer';
import 'package:detectivce_dashboard/modules/ptt/model/ptt_response.dart';
import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

class PTTViewModel with ChangeNotifier {
  // 要被動態刷新的資料，取用以及被設定後會通知
  List<PTTResponse> _pttList = [];

  List<PTTResponse> get pttList => _pttList;

  set pttList(List<PTTResponse> value) {
    _pttList = value;
    notifyListeners();
  }

  Future getPTT() async {
    try {
      pttList = await APIClient.instance.getPTT();
    } catch (e) {
      log("error: $e");
    }
  }
}
