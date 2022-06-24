import 'package:detectivce_dashboard/modules/news/model/news_response.dart';
import 'package:detectivce_dashboard/modules/news/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/app_router.dart';
import '../../../common/view/ProviderWidget.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<NewsViewModel>(
      vm: NewsViewModel(),
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
            return getNewsItem(vm.newsList[i], context);
          }),
        ));
      },
    );
  }

  Widget getNewsItem(NewsResponse data, BuildContext context) {
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
