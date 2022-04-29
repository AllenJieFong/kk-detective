import 'package:flutter/material.dart';

import '../modules/ptt/view/ptt_detail_page.dart';

class AppRouter {
  static AppRouter instance = AppRouter();
  static const pttDetail = "/ptt_detail";

  Map<String, Widget Function(BuildContext)> routers = {
    pttDetail: (_) => PTTDetailPage()
  };
}
