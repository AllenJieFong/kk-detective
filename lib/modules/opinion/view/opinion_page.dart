import 'package:detectivce_dashboard/common/util/time_util.dart';
import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/modules/opinion/model/opinion_model.dart';
import 'package:detectivce_dashboard/modules/opinion/view_model/opinion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loadmore/loadmore.dart';
import 'package:url_launcher/url_launcher.dart';

class OpinionPage extends StatelessWidget {
  OpinionPage({Key? key}) : super(key: key);
  var newsOffset = 0;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<NewsViewModel>(
      vm: NewsViewModel(),
      init: (vm) async {
        await EasyLoading.show();
        await vm.getKKOpinion();
        await EasyLoading.dismiss();
      },
      builder: (context, vm, child) {
        return LoadMore(
          isFinish: vm.isFinish(),
          onLoadMore: vm.loadMore,
          child: ListView.builder(
            // controller: controller,
            shrinkWrap: true,
            itemCount: vm.opinonList.length,
            itemBuilder: (BuildContext context, int index) {
              return getOpinionItem(vm.opinonList[index], context);
            },
          ),
          whenEmptyLoad: false,
          delegate: const DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
        );
      },
    );
  }

  Widget getOpinionItem(OpinionModel data, BuildContext context) {
    Widget content = Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (data.emotionType == 1)
                const Icon(
                  Icons.sentiment_satisfied,
                  size: 80,
                  color: Colors.green,
                )
              else if (data.emotionType == -1)
                const Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 80,
                  color: Colors.red,
                )
              else
                const Icon(
                  Icons.sentiment_neutral,
                  size: 80,
                  color: Colors.grey,
                ),
              IconButton(
                iconSize: 40,
                splashColor:
                    data.isFavorite == true ? Colors.white : Colors.red,
                splashRadius: 30,
                icon: data.isFavorite == true
                    ? const Icon(Icons.favorite, size: 40, color: Colors.red)
                    : const Icon(
                        Icons.favorite_border,
                        size: 40.0,
                      ),
                onPressed: () async {},
              ),
            ]),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // InkWell(
                //   child: const Icon(
                //     Icons.favorite_border,
                //     size: 40.0,
                //   ),
                //   onTap: () async {},
                // ),

                // IconButton(
                //   icon: data.isFavorite == true
                //       ? const Icon(Icons.favorite, size: 40, color: Colors.red)
                //       : const Icon(
                //           Icons.favorite_border,
                //           size: 40.0,
                //         ),
                //   onPressed: () async {},
                // ),
                // onPressed: () async {
                //   var currentLike = vm.isLike[index];
                //   await EasyLoading.show();
                //   await Future.delayed(const Duration(seconds: 1));
                //   vm.setLikeByIndex(index, !currentLike);
                //   await EasyLoading.dismiss();

                const SizedBox(height: 4),
                Text(TimeUtil.getDate(data.updateTime ?? 0),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(data.platform ?? "",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  data.title ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text("更新時間：" + TimeUtil.getDate(data.updateTime ?? 0),
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 8)
              ],
            ),
          ],
        ));
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: InkWell(
          child: content,
          onTap: () async {
            if (!await launchUrl(
              Uri.parse(data.url ?? ""),
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
