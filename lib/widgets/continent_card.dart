import 'package:flutter/material.dart';
import 'package:kovidoverlook/models/continent.dart';
import 'package:kovidoverlook/utils/constant.dart';

class ContinentCard extends StatefulWidget {
  const ContinentCard({
    super.key,
    required this.continent,
    this.onTap,
    this.selected = false,
  });

  final Continent continent;
  final Function(Continent continent)? onTap;
  final bool selected;

  @override
  _ContinentCardState createState() => _ContinentCardState();
}

class _ContinentCardState extends State<ContinentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.selected ? Colors.pink : Colors.white10,
              width: 2.0,
            ),
          ),
          child: _buildBody(),
        ),
        elevation: 2.5,
      ),
      onTap: () => widget.onTap?.call(widget.continent),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: 100.0,
      child: GridTile(
        child: Image.asset(widget.continent.image ?? Constants.defaultImage),
        footer: Container(
          width: double.infinity,
          child: Center(
            child: Text(widget.continent.name ?? ''),
          ),
          padding: const EdgeInsets.all(4.0),
          color: Colors.pinkAccent[100],
        ),
      ),
    );
  }
}
