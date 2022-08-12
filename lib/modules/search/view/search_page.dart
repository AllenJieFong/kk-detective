import 'package:detectivce_dashboard/common/theme/app_colors.dart';
import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/common/view/common_ui.dart';
import 'package:detectivce_dashboard/common/view/item_news.dart';
import 'package:detectivce_dashboard/modules/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  SearchViewModel vm = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchViewModel>(
      vm: vm,
      init: (vm) async {},
      builder: (context, vm, child) {
        return Column(
          children: [
            getSearchUI(),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: vm.opinonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemNews.getNewsItem(
                        vm.opinonList[index], context, onClickFavorite);
                  },
                ),
              ),
            ),
          ],
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
            onChanged: (text) {
              vm.keyword = text;
            },
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
            await vm.getSearch();
            await EasyLoading.dismiss();
          },
        )
      ],
    );
  }
}
