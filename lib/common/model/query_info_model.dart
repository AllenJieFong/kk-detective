class QueryInfoModel {
  String? query;
  int? rankingValue;
  String? timestamp;

  QueryInfoModel({this.query, this.rankingValue, this.timestamp});

  QueryInfoModel.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    rankingValue = json['rankingValue'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['rankingValue'] = rankingValue;
    data['timestamp'] = timestamp;
    return data;
  }

}