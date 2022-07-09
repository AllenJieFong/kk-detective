import 'package:detectivce_dashboard/common/view/wrap_page.dart';
import 'package:detectivce_dashboard/modules/favorite/view/favorite_page.dart';
import 'package:detectivce_dashboard/modules/opinion/view/opinion_page.dart';
import 'package:detectivce_dashboard/modules/search/view/search_page.dart';
import 'package:detectivce_dashboard/modules/trend/view/trend_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static AppRouter instance = AppRouter();
  static const home = "/home";
  static const search = "/search";
  static const favorite = "/favorite";
  static const trend = "/trend";

  static const pttDetail = "/ptt_detail";

  navigation(BuildContext context, String pageKey) {
    WrapPage page;
    switch (pageKey) {
      case home:
        page = WrapPage(contentPage: OpinionPage());
        break;
      case search:
        page = WrapPage(contentPage: SearchPage());
        break;
      case favorite:
        page = WrapPage(contentPage: const FavoritePage());
        break;
      case trend:
        page = WrapPage(contentPage: const TrendPage());
        break;
      default:
        page = WrapPage(contentPage: OpinionPage());
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }
}
