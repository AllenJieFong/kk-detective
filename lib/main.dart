import 'package:detectivce_dashboard/common/app_shared_data.dart';
import 'package:detectivce_dashboard/common/view/wrap_page.dart';
import 'package:detectivce_dashboard/modules/news/view/news_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setPathUrlStrategy();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSharedData.instance),
      ],
      child: const MaterialApp(
          title: 'KK Detective', home: WrapPage(contentPage: NewsPage())),
    );
  }
}
