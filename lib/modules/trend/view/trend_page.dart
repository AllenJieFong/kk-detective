import 'package:flutter/material.dart';

import '../../../common/app_const.dart';
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
      },
      builder: (context, vm, child) {
        var chartItem = ChartUI.instance.getLineAreaChartItem(
          chartColor: AppColors.textColorHighlight,
          chartResponse: vm.searchResponse,
          chartYType: ChartYType.count,
        );

        var trendList = List.generate(vm.trendList.length, (i) {
          TrendResponse trendResponse = vm.trendList[i];
          return getTrendItem(trendResponse);
        });

        List<Widget> uiList = [];
        uiList.add(chartItem);
        uiList.addAll(trendList);

        return Container(
          color: AppColors.bgColor,
          child: SingleChildScrollView(
            child: Column(children: uiList),
          ),
        );
      },
    );
  }

  Widget getTrendItem(TrendResponse data) {
    var isHot = data.formattedValue == "飆升";
    String title = data.query ?? "";
    if (isHot) {
      title += "[飆升]";
    }
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            CommonUI.commonText(title,
                size: 20,
                color: isHot ? AppColors.chartColor1 : AppColors.buttonColor),
            const SizedBox(width: 10),
            CommonUI.commonText(
              data.value.toString(),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
