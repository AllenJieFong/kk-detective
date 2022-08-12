import 'package:detectivce_dashboard/common/model/query_info_model.dart';

class RelatedQueriesResponse {
  List<QueryInfoModel>? top;
  List<QueryInfoModel>? rising;

  RelatedQueriesResponse({this.top, this.rising});

  RelatedQueriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['top'] != null) {
      top = <QueryInfoModel>[];
      json['top'].forEach((v) {
        top!.add(QueryInfoModel.fromJson(v));
      });
    }

    if (json['rising'] != null) {
      rising = <QueryInfoModel>[];
      json['rising'].forEach((v) {
        rising!.add(QueryInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (top != null) {
      data['top'] = top!.map((v) => v.toJson()).toList();
    }
    if (rising != null) {
      data['rising'] = rising!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}