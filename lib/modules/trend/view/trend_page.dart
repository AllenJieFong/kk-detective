import 'package:flutter/material.dart';

import '../../../common/app_const.dart';
import '../../../common/model/query_info_model.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/view/ProviderWidget.dart';
import '../../../common/view/chart_ui.dart';
import '../../../common/view/common_ui.dart';
import '../model/trend_response.dart';
import '../view_model/trend_view_model.dart';

class TrendPage extends StatelessWidget {
  const TrendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TrendViewModel>(
      vm: TrendViewModel(),
      init: (vm) {
        vm.getSearch();
        vm.getTrend();
        vm.getRelatedQuery();
      },
      builder: (context, vm, child) {
        var chartItem = ChartUI.instance.getLineAreaChartItem(
          chartColor: AppColors.textColorHighlight,
          chartResponse: vm.searchResponse,
          chartYType: ChartYType.count,
        );

        var relatedQueryTopList = List.generate(vm.relatedQueriesResponse?.top?.length ?? 0, (i) {
          QueryInfoModel? topQuery = vm.relatedQueriesResponse?.top![i];
          return getRelatedQueryTopItem(topQuery!);
        });

        var relatedQueryRisingList = List.generate(vm.relatedQueriesResponse?.rising?.length ?? 0, (i) {
          QueryInfoModel? risingQuery = vm.relatedQueriesResponse?.rising![i];
          return getRelatedQueryRisingItem(risingQuery!);
        });

        List<Widget> uiList = [];
        uiList.add(chartItem);
        uiList.addAll(relatedQueryRisingList);
        uiList.addAll(relatedQueryTopList);
        print("relatedQueryRisingList $relatedQueryRisingList");
        return Container(
          color: AppColors.bgColor,
          child: SingleChildScrollView(
            child: Column(children: uiList),
          ),
        );
      },
    );
  }

  Widget getRelatedQueryTopItem(QueryInfoModel data) {
    String title = data.query ?? "";
      title += " [Top]";
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            CommonUI.commonText(title,
                size: 20,
                color: AppColors.chartColor1),
            const SizedBox(width: 10),
            CommonUI.commonText(
              data.rankingValue.toString(),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getRelatedQueryRisingItem(QueryInfoModel data) {
    String title = data.query ?? "";
    title += " [Rising]";
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            CommonUI.commonText(title,
                size: 20,
                color: AppColors.chartColor1),
            const SizedBox(width: 10),
            CommonUI.commonText(
              data.rankingValue.toString(),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
