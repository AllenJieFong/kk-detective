import 'package:detectivce_dashboard/common/theme/app_colors.dart';
import 'package:detectivce_dashboard/common/view/common_ui.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final bool isSmallScreen;
  final VoidCallback? onTapMenu;
  const TitleBar({
    Key? key,
    this.isSmallScreen = false,
    this.onTapMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 150,
          height: 60,
          color: AppColors.bgPrimary,
          child: Align(
              alignment: Alignment.center,
              child: CommonUI.commonText("KK Detective")),
        ),
        const SizedBox(width: 20),
        if (isSmallScreen)
          IconButton(
              icon: const Icon(
                Icons.menu,
                size: 24,
              ),
              onPressed: onTapMenu),
        Expanded(child: Container()),
      ],
    );
  }
}
