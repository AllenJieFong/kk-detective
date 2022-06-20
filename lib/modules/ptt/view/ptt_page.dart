import 'package:detectivce_dashboard/modules/ptt/model/news_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/app_router.dart';
import '../../../common/view/ProviderWidget.dart';
import '../view_model/ptt_view_model.dart';

class PTTPage extends StatelessWidget {
  const PTTPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PTTViewModel>(
      vm: PTTViewModel(),
      init: (vm) async {
        await vm.getNews();
      },
      builder: (context, vm, child) {
        return SingleChildScrollView(
            child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: List.generate(vm.newsList.length, (i) {
            return getPTTItem(vm.newsList[i], context);
          }),
        ));
      },
    );
  }

  Widget getPTTItem(NewsResponse data, BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: InkWell(
          child: Text(
            data.title ?? "",
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
