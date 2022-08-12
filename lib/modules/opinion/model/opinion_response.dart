import 'package:detectivce_dashboard/common/model/news_model.dart';

class OpinonResponse {
  int? totalCount;
  List<NewsModel>? news;

  OpinonResponse({this.totalCount, this.news});

  OpinonResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'] ?? 0;
    if (json['news'] != null) {
      news = <NewsModel>[];
      json['news'].forEach((v) {
        news!.add(NewsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
