import 'dart:developer';
import 'package:detectivce_dashboard/common/model/news_model.dart';
import 'package:detectivce_dashboard/modules/opinion/model/opinion_response.dart';
import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

class OpinionViewModel with ChangeNotifier {
  final List<NewsModel> _opinonList = [];
  List<NewsModel> get opinonList => _opinonList;

  int totalCount = 0;
  int offset = 0;

  bool isFinish() => offset + APIClient.apiLimit >= totalCount;

  void addOpinonList(List<NewsModel> list) {
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
