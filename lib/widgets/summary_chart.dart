import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kovidoverlook/models/report.dart';
import 'package:kovidoverlook/widgets/animation_notifier.dart';
import 'package:provider/provider.dart';


class SummaryChart extends StatefulWidget {
  SummaryChart({Key key, @required this.report, this.size, this.showPercent}) : super(key: key);

  final Report report;
  final double size;
  final bool showPercent;

  @override
  State<StatefulWidget> createState() => SummaryChartState();
}

class SummaryChartState extends State<SummaryChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    if (null == widget.report || 0 == widget.report.total) {
      return SizedBox(width: widget.size * 2.0, height: widget.size * 2.0,);
    }

    return Consumer<AnimationNotifier>(
      builder: (context, notifier, child) => PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  pieTouchResponse.touchInput is FlPanEnd) {
                touchedIndex = -1;
              } else {
                touchedIndex = pieTouchResponse.touchedSectionIndex;
              }
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(notifier),
        ),
      ),

    );
  }

  List<PieChartSectionData> showingSections(AnimationNotifier notifier) {
    double total = widget.report.total;
    var mapList = [
      {
        "id": 0,
        "percent": widget.report.deaths / total,
        "color" : Colors.red,
      },
      {
        "id": 1,
        "percent": widget.report.recovered / total,
        "color" : Colors.green,
      },
      {
        "id": 2,
        "percent": widget.report.confirmed / total,
        "color" : Colors.blue,
      },
    ];

    return mapList.map((e) => PieChartSectionData(
      color: e['color'],
      value: (e['percent'] as num) * notifier.value,
      title: widget.showPercent
          ? (
                (e['percent'] as num) * notifier.value * 100
            ).toStringAsFixed(1) + '%'
          : '',
      radius: e['id'] == touchedIndex
          ? widget.size + 10
          : widget.size,
      titleStyle: TextStyle(
        fontSize: e['id'] == touchedIndex ? 20 : 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    )).toList();

  }
}


