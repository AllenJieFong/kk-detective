import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/app_router.dart';
import '../../../common/view/ProviderWidget.dart';
import '../model/ptt_response.dart';
import '../view_model/ptt_view_model.dart';

class PTTPage extends StatelessWidget {
  PTTPage({Key? key}) : super(key: key);
  var vm = PTTViewModel();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PTTViewModel>(
      vm: vm,
      init: (vm) async {
        await EasyLoading.show();
        // await vm.getPtt();
        await Future.delayed(const Duration(seconds: 1));
        await EasyLoading.dismiss();
      },
      builder: (context, vm, child) {
        // return SingleChildScrollView(
        //     child: StaggeredGrid.count(
        //   crossAxisCount: 4,
        //   mainAxisSpacing: 4,
        //   crossAxisSpacing: 4,
        //   children: List.generate(vm.pttList.length, (i) {
        //     PTTResponse pttResponse = vm.pttList[i];
        //     return getPTTItem();
        //   }),
        // ));
        return Column(
          children: [
            getPTTItem(0),
            getPTTItem(1),
            getPTTItem(2),
          ],
        );
      },
    );
  }

  Widget getPTTItem(int index) {
    return Card(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (index == 0)
                const Icon(
                  Icons.sentiment_satisfied,
                  size: 40,
                  color: Colors.green,
                ),
              if (index == 1)
                const Icon(
                  Icons.sentiment_neutral,
                  size: 40,
                  color: Colors.orange,
                ),
              if (index == 2)
                const Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 40,
                  color: Colors.red,
                ),
              IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                    color: vm.isLike[index] ? Colors.red : Colors.grey,
                  ),
                  onPressed: () async {
                    var currentLike = vm.isLike[index];
                    await EasyLoading.show();
                    await Future.delayed(const Duration(seconds: 1));
                    vm.setLikeByIndex(index, !currentLike);
                    await EasyLoading.dismiss();
                  }),
            ],
          )),
    );
  }
}
