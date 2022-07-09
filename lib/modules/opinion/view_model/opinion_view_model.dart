import 'dart:developer';

import 'package:detectivce_dashboard/modules/opinion/model/opinion_model.dart';
import 'package:detectivce_dashboard/modules/opinion/model/opinion_response.dart';
import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

class NewsViewModel with ChangeNotifier {
  final List<OpinionModel> _opinonList = [];
  List<OpinionModel> get opinonList => _opinonList;

  int totalCount = 0;
  int offset = 0;

  bool isFinish() => offset + APIClient.apiLimit >= totalCount;

  void addOpinonList(List<OpinionModel> list) {
    _opinonList.addAll(list);
    notifyListeners();
  }

  Future getKKOpinion() async {
    try {
      OpinonResponse opinonResponse =
          await APIClient.instance.getKKOpinion(offset: offset);
      totalCount = opinonResponse.totalCount ?? 0;
      addOpinonList(opinonResponse.news ?? []);
    } catch (e) {
      log("error: $e");
    }
  }

  Future<bool> loadMore() async {
    offset += APIClient.apiLimit;
    await getKKOpinion();
    return true;
  }

  Future<void> refresh() async {
    offset = 0;
    _opinonList.clear();
    getKKOpinion();
  }
}
