import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/modules/news/model/news_response.dart';
import 'package:detectivce_dashboard/modules/news/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child: Column(
            children: List.generate(
              vm.newsList.length,
              (i) {
                return getNewsItem(vm.newsList[i], context);
              },
            ),
          ),
        );
      },
    );
  }

  Widget getNewsItem(NewsResponse data, BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: InkWell(
          child: Text(
            data.title ?? "",
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () async {
            if (!await launchUrl(
              // Uri.parse(data.url ?? ""),
              // TODO for demo
              Uri.parse("http://www.google.com"),
              mode: LaunchMode.platformDefault,
            )) {
              throw 'Could not launch ${data.url}';
            }
          },
        ),
      ),
    );
  }
}
