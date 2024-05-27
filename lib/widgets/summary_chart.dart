import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kovidoverlook/models/report.dart';
import 'package:kovidoverlook/widgets/animation_notifier.dart';
import 'package:provider/provider.dart';

class SummaryChart extends StatefulWidget {
  const SummaryChart({
    super.key,
    this.report,
    this.size = 0,
    this.showPercent = false,
  });

  final Report? report;
  final double size;
  final bool showPercent;

  @override
  State<StatefulWidget> createState() => SummaryChartState();
}

class SummaryChartState extends State<SummaryChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (null == widget.report || 0 == widget.report!.total) {
      return SizedBox(
        width: widget.size * 2.0,
        height: widget.size * 2.0,
      );
    }

    return Consumer<AnimationNotifier>(
      builder: (context, notifier, child) => PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (event, pieTouchResponse) {
              setState(() {
                if (event is FlLongPressEnd || event is FlPanEndEvent) {
                  touchedIndex = -1;
                } else {
                  touchedIndex =
                      pieTouchResponse?.touchedSection?.touchedSectionIndex ??
                          -1;
                }
              });
            },
          ),
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
    double total = widget.report!.total;
    var mapList = [
      {
        "id": 0,
        "percent": widget.report!.deaths / total,
        "color": Colors.red,
      },
      {
        "id": 1,
        "percent": widget.report!.recovered / total,
        "color": Colors.green,
      },
      {
        "id": 2,
        "percent": widget.report!.confirmed / total,
        "color": Colors.blue,
      },
    ];

    return mapList
        .map(
          (e) => PieChartSectionData(
            color: e['color'] as Color?,
            value: (e['percent'] as num) * notifier.value,
            title: widget.showPercent || e['id'] == touchedIndex
                ? ((e['percent'] as num) * notifier.value * 100)
                        .toStringAsFixed(1) +
                    '%'
                : '',
            radius: e['id'] == touchedIndex ? widget.size + 10 : widget.size,
            titleStyle: TextStyle(
              fontSize:
                  e['id'] == touchedIndex ? (widget.showPercent ? 20 : 12) : 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
        .toList();
  }
}
