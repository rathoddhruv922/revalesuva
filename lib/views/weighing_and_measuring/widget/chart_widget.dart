import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/weight_and_measuring/chart_model.dart';
import 'package:revalesuva/utils/app_colors.dart';

class ChartWidget extends StatelessWidget {
  ChartWidget({super.key, required this.dataList});

  final List<ChartModel> dataList;
  List<FlSpot> allSpots = [];
  Map<int, String> xLabels = {};
  bool isDataLoad = false;

  manageData() async {
    allSpots.clear();
    xLabels.clear();
    for (var i = 0; i < dataList.length; i++) {
      allSpots.add(FlSpot(double.parse(i.toString()), dataList[i].value ?? 0.0));
      xLabels[i] = dataList[i].date ?? "";
    }
    isDataLoad = true;
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: manageData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ),
          );
        } else {
          if (dataList.isEmpty) {
            return const Center(
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextTitleMedium(
                    text: "No Data Found",
                    color: AppColors.textError,
                  )),
            );
          } else {
            return AspectRatio(
              aspectRatio: 2.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  children: [
                    LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (touchedSpot) {
                              return AppColors.surfacePurpleLight.withValues(alpha: 0.5);
                            },
                          ),
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          verticalInterval: 1,
                          drawHorizontalLine: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: axisTitles,
                          rightTitles: axisTitles,
                          topTitles: axisTitles,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 20,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                Widget text;
                                if (xLabels.containsKey(value.toInt())) {
                                  text = RotationTransition(
                                    turns: const AlwaysStoppedAnimation(-30 / 360),
                                    child: TextBodySmall(
                                      text: xLabels[value.toInt()]!,
                                      color: AppColors.textPrimary,
                                      size: -3,
                                    ),
                                  );
                                } else {
                                  text = const TextBodySmall(
                                    text: '',
                                    color: AppColors.textPrimary,
                                  );
                                }
                                // Replaced SideTitleWidget with Padding for proper spacing.
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: text,
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            showingIndicators: [1],
                            shadow: Shadow(blurRadius: 2, color: Colors.black.withValues(alpha: 0.5)),
                            spots: allSpots,
                            isCurved: false,
                            isStrokeJoinRound: false,
                            color: AppColors.surfacePurple,
                            show: true,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                radius: 4,
                                color: Colors.white,
                                strokeWidth: 3,
                                strokeColor: AppColors.surfacePurple,
                              ),
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              spotsLine: const BarAreaSpotsLine(
                                  flLineStyle: FlLine(color: AppColors.surfacePurple, strokeWidth: 1), show: true),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.surfacePurple.withValues(alpha: 0.7),
                                  AppColors.surfacePurple.withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  final axisTitles = const AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  );
}
