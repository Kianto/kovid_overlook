import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kovidoverlook/models/country.dart';
import 'package:kovidoverlook/widgets/animation_notifier.dart';
import 'package:kovidoverlook/widgets/summary_chart.dart';
import 'package:provider/provider.dart';

class CountryCard extends StatefulWidget {
  CountryCard({Key key, @required this.country, this.onTap}) : super(key: key);

  final Country country;
  final Function(Country country) onTap;

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> with TickerProviderStateMixin {
  AnimationController _animationCtrler;

  @override
  void initState() {
    super.initState();

    _animationCtrler = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationCtrler.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationNotifier>(
      builder: (context, notifier, child) {
        if (1 == notifier.value) _animationCtrler.forward();
        else if (_animationCtrler.isCompleted) _animationCtrler.reverse();

        return Transform.translate(
          offset: Offset(64 * (1 - notifier.value), 0),
          child: Opacity(
            opacity: notifier.value,
            child: InkWell(
              child: Card(
                color: Colors.white70,
                child: _buildBody(notifier),
              ),
              onTap: () => widget.onTap(widget.country),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(AnimationNotifier notifier) {
    return ListTile(
      title: Text(widget.country.name),
      subtitle: Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildBoard(
            widget.country.confirmed,
            210.0,
            Colors.blue,
            notifier,
            delay: 0.4,
          ),
          _buildBoard(
            widget.country.recovered,
            140.0,
            Colors.green,
            notifier,
            delay: 0.2,
          ),
          _buildBoard(
            widget.country.deaths,
            70.0,
            Colors.red,
            notifier,
          ),
        ],
      ),
      trailing: SizedBox(
        width: 40.0,
        child: SummaryChart(
          report: widget.country,
          size: 30.0,
          showPercent: false,
        ),
      ),
      leading: FadeInImage.assetNetwork(
        image: widget.country.flag,
        placeholder: 'assets/images/kovid_overlook.png',
      ),
    );
  }

  Widget _buildBoard(int number, double width, Color color, AnimationNotifier notifier, {double delay = 0}) {
    Animation animation = CurvedAnimation(
      parent: _animationCtrler,
      curve: Interval(
        delay,
        1,
        curve: Curves.decelerate,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(math.pi / 2 * (1.0 - animation.value)),
        alignment: Alignment.topCenter,
        child: child,
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(12.0),
            bottomEnd: Radius.circular(12.0),
          ),
          color: color,
        ),
        child: Text(
          ' $number',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        padding: const EdgeInsets.all(4.0),
      ),
    );
  }

}