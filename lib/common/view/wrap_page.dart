import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/common/view/common_ui.dart';
import 'package:detectivce_dashboard/common/view/menu.dart';
import 'package:detectivce_dashboard/common/view/title_bar.dart';
import 'package:flutter/material.dart';

class WrapPage extends StatelessWidget {
  final Widget contentPage;
  final menuItemSize = 3;
  const WrapPage({required this.contentPage});

  // final WrapPageViewModel vm = WrapPageViewModel();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isSmallScreen = screenSize.width < 720;
    var vm = WrapPageViewModel();

    TitleBar titleBar = TitleBar(
      isSmallScreen: isSmallScreen,
      onTapMenu: () async {
        vm.showMenu(context, 4);
      },
    );

    return ProviderWidget<WrapPageViewModel>(
      vm: vm,
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              titleBar,
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isSmallScreen
                        ? Container()
                        : Menu(isSmallScreen: isSmallScreen),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: contentPage),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WrapPageViewModel with ChangeNotifier {
  @override
  Future loadData() async {}

  bool _isShowMenu = false;
  bool get isShowMenu => _isShowMenu;
  set isShowMenu(bool isShow) {
    _isShowMenu = isShow;
    notifyListeners();
  }

  void showMenu(BuildContext ctx, int menuItemSize) async {
    await showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: Align(
              alignment: Alignment.center,
              child: CommonUI.commonText("選單", size: 20)),
          content: SizedBox(
            height: 80 * menuItemSize + 20,
            child: Menu(),
          ),
        );
      },
    );
  }
}
