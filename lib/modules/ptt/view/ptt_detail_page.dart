import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/view/ProviderWidget.dart';
import '../../../common/view/common_ui.dart';
import '../model/ptt_response.dart';
import '../view_model/ptt_view_model.dart';

class PTTDetailPage extends StatelessWidget {
  PTTDetailPage({Key? key}) : super(key: key);
  PTTResponse? data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as PTTResponse;

    return ProviderWidget<PTTViewModel>(
      vm: PTTViewModel(),
      init: (vm) async {},
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
              title: CommonUI.commonText(data?.name ?? "",
                  size: 20, color: AppColors.bgColor)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  child: CommonUI.commonText(data?.content ?? "", size: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
