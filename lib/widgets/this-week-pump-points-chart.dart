import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/styles/styles.dart';

import '../providers/config-provider.dart';

class ThisWeekPumpPointsChart extends ConsumerWidget {
  const ThisWeekPumpPointsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> pumpPointsArr = ref.read(configProvider).archive.getPumpPointsThisWeekArr();

    // List<BarChartGroupData> chartData() {
    //   return <BarChartGroupData>[
    //     for (CompletedWorkout cw in ref.read(configProvider).archive.thisWeeksCompletedWorkouts())
    //       BarChartGroupData(
    //         x: 0,
    //         barRods: [
    //           BarChartRodData(toY: (cw.getPumpPoints().toDouble())),
    //         ],
    //       )
    //   ];
    // }

    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * .25,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: nittanyNavy(),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "PumpPoints",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ref.read(configProvider).archive.getPumpPointsThisWeek().toString(),
              style: TextStyle(color: creek(), fontSize: 40),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "This Week",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: BarChart(
                BarChartData(
                  backgroundColor: Colors.transparent,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          Widget text = Text('');
                          switch (value.toInt()) {
                            case 0:
                              text = Text(
                                'S',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                            case 1:
                              text = Text(
                                'M',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                            case 2:
                              text = Text(
                                'T',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                            case 3:
                              text = Text(
                                'W',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                            case 4:
                              text = Text(
                                'T',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                            case 5:
                              text = Text(
                                'F',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                            case 6:
                              text = Text(
                                'S',
                                style: TextStyle(color: whiteOut()),
                              );
                              break;
                          }
                          return SideTitleWidget(child: text, axisSide: meta.axisSide);
                        },
                      ),
                    ),
                  ),
                  barGroups: <BarChartGroupData>[
                    for (int i = 0; i < 7; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            color: pennsylvaniaSky(),
                            toY: pumpPointsArr[i].toDouble(),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
