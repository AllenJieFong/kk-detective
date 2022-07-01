import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/modules/news/model/news_response.dart';
import 'package:detectivce_dashboard/modules/news/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<NewsViewModel>(
      vm: NewsViewModel(),
      init: (vm) async {
        await EasyLoading.show();
        await vm.getNews();
        await EasyLoading.dismiss();
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [Icon(Icons.tag_faces, size: 80.0)],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.favorite_border, size: 60.0),
                    const SizedBox(height: 4),
                    Text(data.getDate(data.updateTime ?? 0),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(data.platform ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(data.title ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(data.content ?? "",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    Text("更新時間：" + data.getDate(data.updateTime ?? 0),
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    InkWell(
                      child: Text(
                        "連結 ${data.url}",
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        if (!await launchUrl(
                          Uri.parse(data.url ?? ""),
                          mode: LaunchMode.platformDefault,
                        )) {
                          throw 'Could not launch ${data.url}';
                        }
                      },
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
