import 'package:detectivce_dashboard/common/theme/app_colors.dart';
import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/common/view/common_ui.dart';
import 'package:detectivce_dashboard/modules/news/model/news_response.dart';
import 'package:detectivce_dashboard/modules/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  SearchViewModel searchViewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchViewModel>(
      vm: searchViewModel,
      init: (vm) async {
        await EasyLoading.show();
        await vm.getNews();
        await EasyLoading.dismiss();
      },
      builder: (context, vm, child) {
        var uiList = [getSearchUI(), const SizedBox(height: 16)];
        var searchResutlt = List.generate(
          vm.newsList.length,
          (i) {
            return getNewsItem(vm.newsList[i], context);
          },
        );
        uiList.addAll(searchResutlt);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: uiList,
          ),
        );
      },
    );
  }

  Widget getSearchUI() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(
              fontSize: 16,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: "請輸入關鍵字",
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.bgColor, width: 2.0),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.bgPrimary, width: 2.0),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          child: CommonUI.commonText("確定", size: 14),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 50),
            primary: AppColors.bgPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            await EasyLoading.show();
            // TODO call search API
            await EasyLoading.dismiss();
          },
        )
      ],
    );
  }

  Widget getNewsItem(NewsResponse data, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
