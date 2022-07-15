
import 'package:detectivce_dashboard/common/model/transaction_model.dart';

class TransactionResponseV2 {
  String? title;
  String? xAxis;
  String? yAxis;
  List<TransactionModel>? dailyIndo;

  TransactionResponseV2({this.title, this.xAxis, this.yAxis, this.dailyIndo});

  TransactionResponseV2.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    xAxis = json['x_axis'];
    yAxis = json['y_axis'];
    if (json['daily_info'] != null) {
      dailyIndo = <TransactionModel>[];
      json['daily_info'].forEach((v) {
        dailyIndo!.add(TransactionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['x_axis'] = xAxis;
    data['y_axis'] = yAxis;
    if (dailyIndo != null) {
      data['daily_info'] = dailyIndo!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}