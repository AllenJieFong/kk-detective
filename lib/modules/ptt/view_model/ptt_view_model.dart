import 'dart:developer';
import 'package:flutter/material.dart';

import '../../../network/api_client.dart';
import '../model/ptt_response.dart';

class PTTViewModel with ChangeNotifier {
  // 要被動態刷新的資料，取用以及被設定後會通知
  List<PTTResponse> _pttList = [];
  List<PTTResponse> get pttList => _pttList;
  set pttList(List<PTTResponse> value) {
    _pttList = value;
    notifyListeners();
  }

  // 呼叫API的方法
  Future getPtt() async {
    try {
      pttList = await APIClient.instance.getPTT();
    } catch (e) {
      log("error: $e");
    }
  }

  List<bool> _isLike = [false, false, false];
  List<bool> get isLike => _isLike;
  set isLike(List<bool> value) {
    _isLike = value;
    notifyListeners();
  }

  void setLikeByIndex(int index, bool isLike) {
    _isLike[index] = isLike;
    notifyListeners();
  }
}
