import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/common/view/item_news.dart';
import 'package:detectivce_dashboard/modules/favorite/view_model/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  FavoriteViewModel vm = FavoriteViewModel();
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavoriteViewModel>(
      vm: vm,
      init: (vm) async {
        await EasyLoading.show();
        await vm.getFavorite();
        await EasyLoading.dismiss();
      },
      builder: (context, vm, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: vm.opinonList.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemNews.getNewsItem(
                vm.opinonList[index], context, onClickFavorite);
          },
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
