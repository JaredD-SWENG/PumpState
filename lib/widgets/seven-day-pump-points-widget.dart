import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/styles/styles.dart';

import '../providers/config-provider.dart';

class SevenDayPumpPoints extends ConsumerWidget {
  const SevenDayPumpPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    List<BarChartGroupData> groupData = [
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 10, color: Color(0xff43dde6)),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 8.5, color: Color(0xff43dde6)),
      ]),
    ];

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.width * 0.95 * 0.65,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: slate(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "PumpPoints This Week",
            style: Theme.of(context).textTheme.headline5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: BarChart(
                BarChartData(
                  backgroundColor: nittanyNavy(),
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
                              text = Text('S');
                              break;
                            case 1:
                              text = Text('M');
                              break;
                            case 2:
                              text = Text('T');
                              break;
                            case 3:
                              text = Text('W');
                              break;
                            case 4:
                              text = Text('T');
                              break;
                            case 5:
                              text = Text('F');
                              break;
                            case 6:
                              text = Text('S');
                              break;
                          }
                          return SideTitleWidget(child: text, axisSide: meta.axisSide);
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                          toY: 0.0,
                        )
                      ],
                    )
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
