import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/common/view/item_news.dart';
import 'package:detectivce_dashboard/modules/opinion/view_model/opinion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loadmore/loadmore.dart';

class OpinionPage extends StatelessWidget {
  OpinionPage({Key? key}) : super(key: key);
  var newsOffset = 0;
  final ScrollController controller = ScrollController();
  final OpinionViewModel vm = OpinionViewModel();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<OpinionViewModel>(
      vm: vm,
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
            shrinkWrap: true,
            itemCount: vm.opinonList.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemNews.getNewsItem(
                  vm.opinonList[index], context, onClickFavorite);
            },
          ),
          whenEmptyLoad: false,
          delegate: const DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
        );
      },
    );
  }

  Future<void> onClickFavorite(
      String sourceType, String id, bool isFavorite) async {
    await EasyLoading.show();
    await vm.changeFavorite(sourceType, id, isFavorite);
    await EasyLoading.dismiss();
  }
}
