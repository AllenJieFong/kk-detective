import 'dart:convert';
import 'dart:developer';

import 'package:detectivce_dashboard/modules/favorite/model/favorite_response.dart';
import 'package:detectivce_dashboard/modules/opinion/model/opinion_response.dart';
import 'package:dio/dio.dart';

import '../common/model/chart_response.dart';
import '../modules/trend/model/trend_response.dart';

class DioClient {
  static DioClient instance = DioClient();
  String apiBaseUrl = "https://detective-c8bd7.loyi.dev/";

  Map<String, dynamic> get baseHeaders => {
        // "token": "xxx",
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
  static const int apiLimit = 20;

  Future<OpinonResponse> getKKOpinion(
      {int offset = 0, int limit = apiLimit}) async {
    try {
      String path = "opinion/latest";
      final response = await dio
          .get(path, queryParameters: {"offset": offset, "limit": limit});
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      final responseData = jsonData["data"];
      return OpinonResponse.fromJson(responseData);
    } catch (e) {
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
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
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
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
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
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      final data = jsonData["data"];
      final result = ChartResponse.fromJson(data);
      return result;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<OpinonResponse> getSearch(String keyword) async {
    try {
      String path = "search/all/";
      final response = await dio.get(path, queryParameters: {"q": keyword});
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      final responseData = jsonData["data"];
      return OpinonResponse.fromJson(responseData);
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<FavoriteResponse> getFavorite() async {
    try {
      String path = "favourite/show_all/";
      final response = await dio.get(path);
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      final responseData = jsonData["data"];
      return FavoriteResponse.fromJson(responseData);
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<bool> addFavorite(String sourceType, String id) async {
    try {
      String path = "favourite/add/";
      final response = await dio
          .get(path, queryParameters: {"table": sourceType, "index": id});
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      return true;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<bool> removeFavorite(String sourceType, String id) async {
    try {
      String path = "favourite/remove/";
      final response = await dio
          .get(path, queryParameters: {"table": sourceType, "index": id});
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      return true;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }
}
