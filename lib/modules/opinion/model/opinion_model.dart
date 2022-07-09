class OpinionModel {
  String? sourceType;
  int? id;
  String? title;
  String? url;
  String? platform;
  int? updateTime;
  bool? isFavorite;
  int? emotionType;

  OpinionModel(
      {this.sourceType,
      this.id,
      this.title,
      this.url,
      this.platform,
      this.updateTime,
      this.isFavorite,
      this.emotionType});

  OpinionModel.fromJson(Map<String, dynamic> json) {
    sourceType = json['source_type'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    platform = json['platform'];
    updateTime = json['update_time'];
    isFavorite = json['is_favorite'];
    emotionType = json['emotion_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source_type'] = sourceType;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['platform'] = platform;
    data['update_time'] = updateTime;
    data['is_favorite'] = isFavorite;
    data['emotion_type'] = emotionType;
    return data;
  }
}
