import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../app_const.dart';
import '../model/chart_response.dart';
import '../theme/app_colors.dart';
import 'common_ui.dart';

class ChartUI {
  static ChartUI instance = ChartUI();

  final TooltipBehavior _lineTooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        DailyInfo dailyInfo = data as DailyInfo;
        return Container(
          padding: const EdgeInsets.all(10),
          child: CommonUI.commonText(
              'Date: ${dailyInfo.dateTime}\nValue: ${dailyInfo.transaction ?? dailyInfo.percentage}',
              color: Colors.white),
        );
      });

  final TooltipBehavior _pieTooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        DailyInfo dailyInfo = data as DailyInfo;
        return Container(
          padding: const EdgeInsets.all(10),
          child: CommonUI.commonText(
              "${dailyInfo.dateTime}\n 數量: ${dailyInfo.transaction} 比例: ${dailyInfo.percentage}",
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
    required ChartResponse? chartResponse,
    required ChartYType chartYType,
  }) {
    List<DailyInfo> chartData = chartResponse?.dailyInfo ?? [];
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
            series: <SplineAreaSeries<DailyInfo, String>>[
              SplineAreaSeries<DailyInfo, String>(
                dataSource: chartData,
                xValueMapper: (DailyInfo data, _) => data.dateTime,
                yValueMapper: (DailyInfo data, _) =>
                    chartYType == ChartYType.count
                        ? data.transaction
                        : data.percentage,
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
      required ChartResponse? chartResponse,
      required ChartYType chartYType}) {
    List<DailyInfo> chartData = chartResponse?.dailyInfo ?? [];
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
              PieSeries<DailyInfo, String>(
                dataSource: chartData,
                xValueMapper: (DailyInfo data, _) => data.dateTime,
                yValueMapper: (DailyInfo data, _) => data.percentage,
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
      required ChartResponse? chartResponse,
      required ChartYType chartYType}) {
    List<DailyInfo> chartData = chartResponse?.dailyInfo ?? [];
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
              BarSeries<DailyInfo, String>(
                dataSource: chartData,
                xValueMapper: (DailyInfo data, _) => data.dateTime,
                yValueMapper: (DailyInfo data, _) => data.percentage,
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
