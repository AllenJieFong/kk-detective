import 'package:detectivce_dashboard/modules/opinion/model/opinion_model.dart';

class OpinonResponse {
  int? totalCount;
  List<OpinionModel>? news;

  OpinonResponse({this.totalCount, this.news});

  OpinonResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['news'] != null) {
      news = <OpinionModel>[];
      json['news'].forEach((v) {
        news!.add(OpinionModel.fromJson(v));
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
