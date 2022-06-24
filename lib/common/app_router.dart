import 'package:detectivce_dashboard/common/view/wrap_page.dart';
import 'package:detectivce_dashboard/modules/ptt/view/ptt_page.dart';
import 'package:detectivce_dashboard/modules/transaction/view/transaction_page.dart';
import 'package:detectivce_dashboard/modules/trend/view/trend_page.dart';
import 'package:flutter/material.dart';

import '../modules/news/view/news_page.dart';
import '../modules/ptt/view/ptt_detail_page.dart';

class AppRouter {
  static AppRouter instance = AppRouter();
  static const home = "/home";
  static const search = "/search";
  static const favorite = "/favorite";
  static const trend = "/trend";

  static const pttDetail = "/ptt_detail";

  navigation(BuildContext context, String pageKey) {
    var page = const WrapPage(contentPage: NewsPage());
    switch (pageKey) {
      case home:
        page = const WrapPage(contentPage: NewsPage());
        break;
      case search:
        page = const WrapPage(contentPage: TransactionPage());
        break;
      case favorite:
        page = const WrapPage(contentPage: NewsPage());
        break;
      case trend:
        page = const WrapPage(contentPage: TrendPage());
        break;
      case pttDetail:
        page = WrapPage(contentPage: PTTDetailPage());
        break;
      default:
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
