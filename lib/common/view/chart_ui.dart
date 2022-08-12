import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../app_const.dart';
import '../model/transaction_model.dart';
import '../model/transaction_response_v2.dart';
import '../theme/app_colors.dart';
import 'common_ui.dart';

class ChartUI {
  static ChartUI instance = ChartUI();

  final TooltipBehavior _lineTooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        TransactionModel dailyInfo = data as TransactionModel;
        return Container(
          padding: const EdgeInsets.all(10),
          child: CommonUI.commonText(
              'Date: ${dailyInfo.date}\nValue: ${dailyInfo.transaction ?? dailyInfo.transaction}',
              color: Colors.white),
        );
      });

  final TooltipBehavior _pieTooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        TransactionModel dailyInfo = data as TransactionModel;
        return Container(
          padding: const EdgeInsets.all(10),
          child: CommonUI.commonText(
              "${dailyInfo.date}\n 數量: ${dailyInfo.transaction} 比例: ${dailyInfo.transaction}",
              color: Colors.white),
        );
      });

  final LinearGradient _linearGradient = const LinearGradient(
    colors: [
      AppColors.chartColor1,
      AppColors.textColorHighlight,
    ],
    stops: [
      0.1,
      1.0,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  Widget getLineAreaChartItem({
    required Color chartColor,
    required TransactionResponseV2? chartResponse,
    required ChartYType chartYType,
  }) {
    List<TransactionModel> chartData = chartResponse?.dailyIndo ?? [];
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.unselectedColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonUI.commonText(chartResponse?.title ?? ""),
          CommonUI.commonText(
              "X: ${chartResponse?.xAxis ?? ''} Y: ${chartResponse?.yAxis ?? ''}"),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              labelRotation: -45,
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
            ),
            tooltipBehavior: _lineTooltipBehavior,
            series: <SplineAreaSeries<TransactionModel, String>>[
              SplineAreaSeries<TransactionModel, String>(
                dataSource: chartData,
                xValueMapper: (TransactionModel data, _) => data.date,
                yValueMapper: (TransactionModel data, _) =>
                chartYType == ChartYType.count
                    ? data.transaction
                    : data.transaction,
                gradient: _linearGradient,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  height: 4,
                  width: 4,
                  color: Colors.black,
                  borderColor: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getPieChartItem(
      {required Color chartColor,
        required TransactionResponseV2? chartResponse,
        required ChartYType chartYType}) {
    List<TransactionModel> chartData = chartResponse?.dailyIndo ?? [];
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.unselectedColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CommonUI.commonText(chartResponse?.title ?? ""),
          SfCircularChart(
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: _pieTooltipBehavior,
            series: <CircularSeries>[
              PieSeries<TransactionModel, String>(
                dataSource: chartData,
                xValueMapper: (TransactionModel data, _) => data.date,
                yValueMapper: (TransactionModel data, _) => data.transaction,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getBarChartItem(
      {required Color chartColor,
        required TransactionResponseV2? chartResponse,
        required ChartYType chartYType}) {
    List<TransactionModel> chartData = chartResponse?.dailyIndo ?? [];
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.unselectedColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CommonUI.commonText(chartResponse?.title ?? ""),
          SfCartesianChart(
            isTransposed: true,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              labelRotation: -45,
            ),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: _pieTooltipBehavior,
            series: <ChartSeries>[
              BarSeries<TransactionModel, String>(
                dataSource: chartData,
                xValueMapper: (TransactionModel data, _) => data.date,
                yValueMapper: (TransactionModel data, _) => data.transaction,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
