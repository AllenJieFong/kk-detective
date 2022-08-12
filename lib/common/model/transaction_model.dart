class TransactionModel {
  String? date;
  int? transaction;

  TransactionModel(
      {this.date,
        this.transaction});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    transaction = json['transaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['transaction'] = transaction;
    return data;
  }
}