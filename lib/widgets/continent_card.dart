import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kovidoverlook/models/continent.dart';

class ContinentCard extends StatefulWidget {
  ContinentCard({Key key, @required this.continent, this.onTap, this.selected}) : super(key: key);

  final Continent continent;
  final Function(Continent continent) onTap;
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
            )
          ),
          child: _buildBody(),
        ),
        elevation: 2.5,
      ),
      onTap: () => widget.onTap(widget.continent),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: 100.0,
      child: GridTile(
        child: Image.asset(widget.continent.image),
        footer: Container(
          width: double.infinity,
          child: Center(
            child: Text(widget.continent.name),
          ),
          padding: EdgeInsets.all(4.0),
          color: Colors.pinkAccent[100],
        ),
      ),
    );
  }

}