class TrendResponse {
  String? query;
  int? value;
  String? formattedValue;
  String? link;

  TrendResponse({this.query, this.value, this.formattedValue, this.link});

  TrendResponse.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    value = json['value'];
    formattedValue = json['formattedValue'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['value'] = value;
    data['formattedValue'] = formattedValue;
    data['link'] = link;
    return data;
  }
}
