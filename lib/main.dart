import 'package:detectivce_dashboard/common/app_shared_data.dart';
import 'package:detectivce_dashboard/common/view/wrap_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/ptt/view/ptt_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSharedData.instance),
      ],
      child: const MaterialApp(
          title: 'KK Detective', home: WrapPage(contentPage: PTTPage())),
    );
  }
}
