import 'package:detectivce_dashboard/common/app_router.dart';
import 'package:detectivce_dashboard/common/app_shared_data.dart';
import 'package:detectivce_dashboard/common/theme/app_colors.dart';
import 'package:detectivce_dashboard/common/view/common_ui.dart';
import 'package:detectivce_dashboard/common/view/wrap_page.dart';
import 'package:detectivce_dashboard/modules/ptt/view/ptt_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  bool isSmallScreen;
  Menu({
    Key? key,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appSharedData = Provider.of<AppSharedData>(context);
    int currentPaggIndex = appSharedData.currentPaggIndex;

    List<Widget> menuList = [
      InkWell(
        child: getNavButton("輿情監控", 0, currentPaggIndex),
        onTap: () {
          appSharedData.currentPaggIndex = 0;
          AppRouter.instance.navigation(context, AppRouter.home);
        },
      ),
      InkWell(
        child: getNavButton("搜尋關鍵字", 1, currentPaggIndex),
        onTap: () {
          appSharedData.currentPaggIndex = 1;
          AppRouter.instance.navigation(context, AppRouter.search);
        },
      ),
      InkWell(
        child: getNavButton("收藏", 2, currentPaggIndex),
        onTap: () {
          appSharedData.currentPaggIndex = 2;
          AppRouter.instance.navigation(context, AppRouter.favorite);
        },
      ),
      InkWell(
        child: getNavButton("Google Trends", 3, currentPaggIndex),
        onTap: () {
          appSharedData.currentPaggIndex = 3;
          AppRouter.instance.navigation(context, AppRouter.trend);
        },
      ),
    ];

    return SizedBox(
        width: isSmallScreen ? 0 : 150,
        child: isSmallScreen
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: menuList,
              ));
  }

  Widget getNavButton(String title, int navIndex, int currentPaggIndex) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 80,
          color: currentPaggIndex == navIndex
              ? AppColors.bgLight
              : AppColors.bgDark,
          child: Align(
              alignment: Alignment.center, child: CommonUI.commonText(title)),
        ),
        Container(
          width: 150,
          height: 1,
          color: AppColors.bgDarker,
        )
      ],
    );
  }
}
