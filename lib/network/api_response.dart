abstract class APIResponse<T> {
  String? errCode;
  String? errMsg;
  String? errType;
  T? data;

  APIResponse({this.errCode, this.errMsg, this.errType, this.data});

  APIResponse.fromJson(Map<String, dynamic> json) {
    errCode = json['errCode'];
    errMsg = json['errMsg'];
    errType = json['errType'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = Map<String, dynamic>();
    res['errCode'] = errCode;
    res['errMsg'] = errMsg;
    res['errType'] = errType;
    res['data'] = data;
    return res;
  }
}
