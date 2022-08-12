import 'package:flutter/material.dart';

import '../../../common/app_const.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/view/ProviderWidget.dart';
import '../../../common/view/chart_ui.dart';
import '../view_model/transaction_view_model.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TransactionViewModel>(
      vm: TransactionViewModel(),
      init: (vm) async {
        Future.wait(
            [vm.getTransaction(), vm.getTransactionRate()]);
      },
      builder: (context, vm, child) {
        return Container(
            color: AppColors.bgColor,
            child: SingleChildScrollView(
              child: Column(children: [
                ChartUI.instance.getLineAreaChartItem(
                  chartColor: AppColors.defaultTextColor,
                  chartResponse: vm.transactionResponse,
                  chartYType: ChartYType.count,
                ),
                ChartUI.instance.getLineAreaChartItem(
                  chartColor: AppColors.defaultTextColor,
                  chartResponse: vm.transactionRateResponse,
                  chartYType: ChartYType.percent,
                ),
                ChartUI.instance.getPieChartItem(
                  chartColor: AppColors.defaultTextColor,
                  chartResponse: vm.commonPieResponse,
                  chartYType: ChartYType.pie,
                ),
                ChartUI.instance.getBarChartItem(
                  chartColor: AppColors.defaultTextColor,
                  chartResponse: vm.commonPieResponse,
                  chartYType: ChartYType.bar,
                )
              ]),
            ));
      },
    );
  }
}
