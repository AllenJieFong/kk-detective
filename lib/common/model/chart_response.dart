class ChartResponse {
  String? title;
  String? xAxis;
  String? yAxis;
  List<DailyInfo>? dailyInfo;

  ChartResponse({this.title, this.xAxis, this.yAxis, this.dailyInfo});

  ChartResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    xAxis = json['x_axis'];
    yAxis = json['y_axis'];
    if (json['daily_info'] != null) {
      dailyInfo = <DailyInfo>[];
      json['daily_info'].forEach((v) {
        dailyInfo!.add(DailyInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['x_axis'] = xAxis;
    data['y_axis'] = yAxis;
    if (dailyInfo != null) {
      data['daily_info'] = dailyInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyInfo {
  String? dateTime;
  int? percentage;
  int? transaction;

  DailyInfo({this.dateTime, this.percentage, this.transaction});

  DailyInfo.fromJson(Map<String, dynamic> json) {
    dateTime = json['date_time'];
    percentage = json['percentage'];
    transaction = json['transaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = dateTime;
    data['percentage'] = percentage;
    data['transaction'] = transaction;
    return data;
  }
}
