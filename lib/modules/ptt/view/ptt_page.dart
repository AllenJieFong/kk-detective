import 'package:detectivce_dashboard/modules/news/model/news_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/app_router.dart';
import '../../../common/view/ProviderWidget.dart';
import '../model/ptt_response.dart';
import '../view_model/ptt_view_model.dart';

class PTTPage extends StatelessWidget {
  const PTTPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PTTViewModel>(
      vm: PTTViewModel(),
      init: (vm) async {
        await vm.getPTT();
      },
      builder: (context, vm, child) {
        return SingleChildScrollView(
            child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: List.generate(vm.pttList.length, (i) {
            PTTResponse pttResponse = vm.pttList[i];
            return getPTTItem(pttResponse, context);
          }),
        ));
      },
    );
  }

  Widget getPTTItem(PTTResponse data, BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: InkWell(
          child: Text(
            data.name ?? "",
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRouter.pttDetail, arguments: data);
          },
        ),
      ),
    );
  }
}
