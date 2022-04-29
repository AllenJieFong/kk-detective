class PTTResponse {
  String? name;
  String? url;
  String? content;

  PTTResponse({this.name, this.url, this.content});

  PTTResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['content'] = content;
    return data;
  }
}
