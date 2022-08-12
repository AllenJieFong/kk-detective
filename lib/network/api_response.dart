abstract class APIResponse<T> {
  String? status;
  String? reason;
  T? data;

  APIResponse({this.status, this.reason, this.data});

  APIResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reason = json['reason'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = Map<String, dynamic>();
    res['status'] = status;
    res['reason'] = reason;
    res['data'] = data;
    return res;
  }
}
