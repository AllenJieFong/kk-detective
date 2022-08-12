import 'dart:developer';

import 'package:detectivce_dashboard/common/model/news_model.dart';
import 'package:detectivce_dashboard/modules/opinion/model/opinion_response.dart';
import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

class SearchViewModel with ChangeNotifier {
  List<NewsModel> _opinonList = [];
  List<NewsModel> get opinonList => _opinonList;
  set opinonList(List<NewsModel> list) {
    _opinonList = list;
    notifyListeners();
  }

  String keyword = "";

  Future getSearch() async {
    try {
      OpinonResponse opinonResponse =
          await APIClient.instance.getSearch(keyword);
      opinonList = opinonResponse.news ?? [];
    } catch (e) {
      log("error: $e");
    }
  }

  Future<bool> changeFavorite(
      String sourceType, String id, bool isFavorite) async {
    isFavorite
        ? await APIClient.instance.removeFavorite(sourceType, id)
        : await APIClient.instance.addFavorite(sourceType, id);

    int newsIndex = findNewsIndex(int.parse(id));
    _opinonList[newsIndex].isFavorite = !isFavorite;
    notifyListeners();
    return true;
  }

  int findNewsIndex(int id) => _opinonList.indexWhere((item) => item.id == id);
}
