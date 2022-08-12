import 'package:detectivce_dashboard/common/util/time_util.dart';
import 'package:detectivce_dashboard/common/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemNews {
  static Widget getNewsItem(
      NewsModel data, BuildContext context, Function onClickFavorite) {
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
              splashColor: data.isFavorite == true ? Colors.white : Colors.red,
              splashRadius: 30,
              icon: data.isFavorite == true
                  ? const Icon(Icons.favorite, size: 40, color: Colors.red)
                  : const Icon(
                      Icons.favorite_border,
                      size: 40.0,
                    ),
              onPressed: () {
                onClickFavorite(
                    data.sourceType, data.id.toString(), data.isFavorite);
              },
            ),
          ]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
          ),
        ],
      ),

      // child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [Text(data.title ?? "")]),

      // child: Expanded(child: Text(data.title ?? "")),
    );
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
