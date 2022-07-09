import 'package:detectivce_dashboard/common/app_shared_data.dart';
import 'package:detectivce_dashboard/common/view/wrap_page.dart';
import 'package:detectivce_dashboard/modules/opinion/view/opinion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 100.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
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
      child: MaterialApp(
          title: 'KK Detective',
          home: WrapPage(contentPage: OpinionPage()),
          builder: EasyLoading.init()),
    );
  }
}
