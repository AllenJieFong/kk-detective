import 'dart:developer';

import 'package:detectivce_dashboard/common/model/news_model.dart';
import 'package:detectivce_dashboard/modules/favorite/model/favorite_response.dart';
import 'package:detectivce_dashboard/network/api_client.dart';
import 'package:flutter/material.dart';

class FavoriteViewModel with ChangeNotifier {
  List<NewsModel> _opinonList = [];
  List<NewsModel> get opinonList => _opinonList;
  set opinonList(List<NewsModel> list) {
    _opinonList = list;
    notifyListeners();
  }

  Future getFavorite() async {
    try {
      FavoriteResponse favoriteResponse =
          await APIClient.instance.getFavorite();
      opinonList = favoriteResponse.favourites ?? [];
    } catch (e) {
      log("error: $e");
    }
  }

  Future<bool> changeFavorite(
      String sourceType, String id, bool isFavorite) async {
    await APIClient.instance.removeFavorite(sourceType, id);

    int newsIndex = findNewsIndex(int.parse(id));
    _opinonList.removeAt(newsIndex);
    notifyListeners();
    return true;
  }

  int findNewsIndex(int id) => _opinonList.indexWhere((item) => item.id == id);
}
