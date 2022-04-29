import 'package:flutter/material.dart';

import 'common/app_router.dart';
import 'modules/ptt/view/ptt_page.dart';
import 'modules/transaction/view/transaction_page.dart';
import 'modules/trend/view/trend_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: AppRouter.instance.routers,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getApi() {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BottomNavigationController(),
    );
  }
}

class BottomNavigationController extends StatefulWidget {
  const BottomNavigationController({Key? key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  //目前選擇頁索引值
  int _currentIndex = 0; //預設值
  final pages = [TransactionPage(), const TrendPage(), const PTTPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KK Detective'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.area_chart_rounded), label: "交易"),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "趨勢"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "PTT"),
        ],
        currentIndex: _currentIndex, //目前選擇頁索引值
        fixedColor: Colors.lightBlue, //選擇頁顏色
        onTap: _onItemClick, //BottomNavigationBar 按下處理事件
      ),
    );
  }

  //BottomNavigationBar 按下處理事件，更新設定當下索引值
  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
