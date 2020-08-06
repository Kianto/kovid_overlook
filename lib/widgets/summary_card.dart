import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kovidoverlook/widgets/animation_notifier.dart';
import 'package:provider/provider.dart';

class SummaryCard extends StatefulWidget {
  SummaryCard({Key key, this.color, this.title, this.number}) : super(key: key);

  final Color color;
  final String title;
  final int number;

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationNotifier>(
      builder: (context, notifier, child) => Card(
        child: _buildBody(notifier),
        color: widget.color.withOpacity(0.9),
      ),
    );
  }

  Widget _buildBody(AnimationNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GridTile(

        footer: AnimatedBuilder(
          builder: (context, _) =>  Center(
            child: Text(
              (widget.number * notifier.value).toStringAsFixed(0),
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          animation: notifier,
        ),

        child: Center(
          child: Text(widget.title, style: Theme.of(context).textTheme.headline6,),
        ),

      ),
    );
  }

}