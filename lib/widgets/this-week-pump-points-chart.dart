import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/styles/styles.dart';

import '../providers/config-provider.dart';

/// Displays an analytics bar chart component of the workouts completed this week
class ThisWeekPumpPointsChart extends ConsumerWidget {
  const ThisWeekPumpPointsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> pumpPointsArr = ref.read(configProvider).archive.getPumpPointsThisWeekArr();

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
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
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.contain,
                child:Text(
                  "PumpPoints earned this week:",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.left,
                )
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ref.read(configProvider).archive.getPumpPointsThisWeek().toString(),
                  style: TextStyle(color: creek(), fontSize: 40),
                ),
              )),
          //Expanded(
              //flex: 1,
              //child: Align(
                //alignment: Alignment.centerLeft,
               //child: Text(
                  //"This Week",
                 // style: Theme.of(context).textTheme.headline6,
               // ),
             // )),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                          Widget text = const Text(''); // Initialize the text to blank
                          // Set the x-axis values
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
                          return SideTitleWidget(axisSide: meta.axisSide, child: text);
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
