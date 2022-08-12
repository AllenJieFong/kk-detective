import 'package:detectivce_dashboard/common/model/news_model.dart';

class FavoriteResponse {
  List<NewsModel>? favourites;

  FavoriteResponse({this.favourites});

  FavoriteResponse.fromJson(Map<String, dynamic> json) {
    if (json['favourites'] != null) {
      favourites = <NewsModel>[];
      json['favourites'].forEach((v) {
        favourites!.add(NewsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favourites != null) {
      data['favourites'] = favourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
