import 'dart:developer';
import 'package:detectivce_dashboard/modules/news/model/news_response.dart';
import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

class NewsViewModel with ChangeNotifier {
  // 要被動態刷新的資料，取用以及被設定後會通知
  List<NewsResponse> _newsList = [];

  List<NewsResponse> get newsList => _newsList;

  set newsList(List<NewsResponse> value) {
    _newsList = value;
    notifyListeners();
  }

  Future getNews() async {
    try {
      newsList = await APIClient.instance.getKKNews();
    } catch (e) {
      log("error: $e");
    }
  }
}
