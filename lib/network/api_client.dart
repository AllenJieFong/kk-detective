import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../common/model/chart_response.dart';
import '../modules/ptt/model/news_response.dart';
import '../modules/ptt/model/ptt_response.dart';
import '../modules/trend/model/trend_response.dart';

class DioClient {
  static DioClient instance = DioClient();
  String apiBaseUrl =
      "https://334d7eef-f64a-4a09-aae7-c83105d30d12.mock.pstmn.io/";

  Map<String, dynamic> get baseHeaders => {
        "token": "xxx",
      };

  Dio init() {
    var dio = Dio(BaseOptions(
      headers: baseHeaders,
      contentType: Headers.jsonContentType,
      baseUrl: apiBaseUrl,
    ));

    dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) {
          log(obj.toString());
        }));

    return dio;
  }
}

class APIClient {
  static APIClient instance = APIClient();
  Dio dio = DioClient.instance.init();

  Future<List<PTTResponse>> getPTT() async {
    try {
      String path = "ptt";
      final response = await dio.get(
        path,
      );
      final jsonData = json.decode(response.data);
      if (jsonData["errCode"] != "200") {
        throw Exception(jsonData["errMsg"]);
      }
      final data = jsonData["data"];
      return List.generate(data.length, (i) => PTTResponse.fromJson(data[i]));
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<List<NewsResponse>> getKKNews() async {
    try {
      String path = "kknews";
      final response = await dio.get(path);
      final jsonData = json.decode(response.data);
      if (jsonData["errCode"] != "200") {
        throw Exception(jsonData["errMsg"]);
      }
      final data = jsonData["data"];
      return List.generate(data.length, (i) => NewsResponse.fromJson(data[i]));
    } catch (e) {
      // e as DioError;
      throw e.toString();
    }
  }

  Future<List<TrendResponse>> getTrend() async {
    try {
      String path = "trend";
      final response = await dio.get(
        path,
      );
      final jsonData = json.decode(response.data);
      if (jsonData["errCode"] != "200") {
        throw Exception(jsonData["errMsg"]);
      }
      final data = jsonData["data"];
      return List.generate(data.length, (i) => TrendResponse.fromJson(data[i]));
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<ChartResponse> getTransaction() async {
    try {
      String path = "transaction";
      final response = await dio.get(
        path,
      );
      final jsonData = json.decode(response.data);
      if (jsonData["errCode"] != "200") {
        throw Exception(jsonData["errMsg"]);
      }
      final data = jsonData["data"];
      final result = ChartResponse.fromJson(data);
      return result;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<ChartResponse> getTransactionRate() async {
    try {
      String path = "transaction_rate";
      final response = await dio.get(
        path,
      );
      final jsonData = json.decode(response.data);
      if (jsonData["errCode"] != "200") {
        throw Exception(jsonData["errMsg"]);
      }
      final data = jsonData["data"];
      final result = ChartResponse.fromJson(data);
      return result;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<ChartResponse> getSearch() async {
    try {
      String path = "search";
      final response = await dio.get(
        path,
      );
      final jsonData = json.decode(response.data);

      final data = jsonData["data"];
      final result = ChartResponse.fromJson(data);
      return result;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<ChartResponse> getCommentPie() async {
    try {
      String path = "comment_pie";
      final response = await dio.get(
        path,
      );
      final jsonData = json.decode(response.data);

      final data = jsonData["data"];
      final result = ChartResponse.fromJson(data);
      return result;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }
}
