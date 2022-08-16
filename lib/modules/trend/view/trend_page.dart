import 'package:flutter/material.dart';

import '../../../common/app_const.dart';
import '../../../common/model/query_info_model.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/view/ProviderWidget.dart';
import '../../../common/view/chart_ui.dart';
import '../../../common/view/common_ui.dart';
import '../view_model/trend_view_model.dart';

class TrendPage extends StatelessWidget {
  const TrendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TrendViewModel>(
      vm: TrendViewModel(),
      init: (vm) {
        vm.getInterestOverTimeh();
        vm.getRelatedQuery();
      },
      builder: (context, vm, child) {
        var chartItem = ChartUI.instance.getLineAreaChartItem(
          chartColor: AppColors.textColorHighlight,
          chartResponse: vm.searchResponse,
          chartYType: ChartYType.count,
        );

        var relatedQueryTopList =
            List.generate(vm.relatedQueriesResponse?.top?.length ?? 0, (i) {
          QueryInfoModel? topQuery = vm.relatedQueriesResponse?.top![i];
          return getRelatedQueryTopItem(topQuery!);
        });

        var relatedQueryRisingList =
            List.generate(vm.relatedQueriesResponse?.rising?.length ?? 0, (i) {
          QueryInfoModel? risingQuery = vm.relatedQueriesResponse?.rising![i];
          return getRelatedQueryRisingItem(risingQuery!);
        });

        List<Widget> uiList = [];
        uiList.add(chartItem);
        uiList.add(getTitleSection("超人氣關鍵字", AppColors.chartColor1));
        uiList.addAll(relatedQueryTopList);
        uiList.add(getTitleSection("飆升關鍵字", AppColors.chartColor3));
        uiList.addAll(relatedQueryRisingList);
        return Container(
          color: AppColors.bgColor,
          child: SingleChildScrollView(
            child: Column(children: uiList),
          ),
        );
      },
    );
  }

  Widget getTitleSection(String title, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        child: CommonUI.commonText(title, size: 30, color: Colors.white),
      ),
    );
  }

  Widget getRelatedQueryTopItem(QueryInfoModel data) {
    String title = data.query ?? "";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        child: Row(
          children: [
            CommonUI.commonText(title, size: 20, color: AppColors.chartColor1),
            const SizedBox(width: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50.0,
                minWidth: 50.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.chartColor1,
                ),
                child: CommonUI.commonText(data.rankingValue.toString(),
                    size: 24, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRelatedQueryRisingItem(QueryInfoModel data) {
    String title = data.query ?? "";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        child: Row(
          children: [
            CommonUI.commonText(title, size: 20, color: AppColors.chartColor3),
            const SizedBox(width: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50.0,
                minWidth: 50.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.chartColor3,
                ),
                child: CommonUI.commonText(data.rankingValue.toString(),
                    size: 24, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
