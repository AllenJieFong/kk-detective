import 'dart:convert';
import 'dart:developer';

import 'package:detectivce_dashboard/modules/favorite/model/favorite_response.dart';
import 'package:detectivce_dashboard/modules/opinion/model/opinion_response.dart';
import 'package:dio/dio.dart';

import '../common/model/related_queries_response.dart';
import '../common/model/transaction_response_v2.dart';
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
      OpinonResponse res = OpinonResponse.fromJson(responseData);
      return OpinonResponse.fromJson(responseData);
    } catch (e) {
      throw e.toString();
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
      return true;
    } catch (e) {
      e as DioError;
      throw e.error;
    }
  }

  Future<TransactionResponseV2> getInterestOverTime() async {
    try {
      String path = "trends/interestOverTime/";
      final response = await dio.get(
        path,
      );
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      final responseData = jsonData["data"];
      return TransactionResponseV2.fromJson(responseData);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RelatedQueriesResponse> getRelatedQuery() async {
    try {
      String path = "trends/relatedQueries/";
      final response = await dio.get(
        path,
      );
      final jsonData = response.data;
      if (jsonData["status"] != "success") {
        throw Exception(jsonData["reason"]);
      }
      final responseData = jsonData["data"];
      return RelatedQueriesResponse.fromJson(responseData);
    } catch (e) {
      throw e.toString();
    }
  }
}
