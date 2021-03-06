class NewsResponse {
  static const String jsonKeyTitle = "title";
  static const String jsonKeyDesc = "desc";
  static const String jsonKeyUrl = "url";
  static const String jsonKeyPlatform = "platform";
  static const String jsonKeyCreateTime = "create_time";
  static const String jsonKeyUpdateTime = "update_time";
  static const String jsonKeyIsFavorite = "isFavorite";
  static const String jsonKeyEmotionType = "emotion_type";

  String? title;
  String? content;
  String? url;
  String? platform;
  int? createTime;
  int? updateTime;
  bool? isFavorite;
  int? emotionType;

  NewsResponse({this.title, this.content});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    title = json[jsonKeyTitle];
    content = json[jsonKeyDesc];
    url = json[jsonKeyUrl];
    platform = json[jsonKeyPlatform];
    createTime = json[jsonKeyCreateTime];
    updateTime = json[jsonKeyUpdateTime];
    isFavorite = json[jsonKeyIsFavorite];
    emotionType = json[jsonKeyEmotionType];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data[jsonKeyTitle] = title;
    data[jsonKeyDesc] = content;
    data[jsonKeyUrl] = url;
    data[jsonKeyPlatform] = platform;
    data[jsonKeyCreateTime] = createTime;
    data[jsonKeyUpdateTime] = updateTime;
    data[jsonKeyIsFavorite] = isFavorite;
    data[jsonKeyEmotionType] = emotionType;
    return data;
  }
}
