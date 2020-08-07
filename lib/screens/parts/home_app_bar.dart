import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kovidoverlook/collectors/continent_col.dart';
import 'package:kovidoverlook/models/continent.dart';
import 'package:kovidoverlook/models/report.dart';
import 'package:kovidoverlook/widgets/continent_card.dart';
import 'package:kovidoverlook/widgets/summary_card.dart';
import 'package:kovidoverlook/widgets/summary_chart.dart';

class HomeAppBar extends StatefulWidget {
  HomeAppBar({Key key, @required this.continent, this.onContinentSelected, this.reports})
      : continents = ContinentCollection.getContinents(),
        super(key: key);

  final Continent continent;
  final Function(Continent) onContinentSelected;
  final List<Continent> continents;
  final List<Report> reports;

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _carouselController = CarouselController();
  int _pointer = 0;

  @override
  Widget build(BuildContext context) {
    if ('*' != widget.continent.id && null != widget.reports) {
      if (0 == widget.continent.total) {
        _pointer = 0;
      }
      for (int i = _pointer; i < widget.reports.length; i++) {
        widget.continent.confirmed += widget.reports[i].confirmed;
        widget.continent.recovered += widget.reports[i].recovered;
        widget.continent.deaths    += widget.reports[i].deaths;
        _pointer ++;
      }
    }
    return _buildBody();
  }

  Widget _buildBody() {
    var continentList = SizedBox(
      height: 180.0,
      child: ListView.builder(
        itemBuilder: (context, index) => ContinentCard(
          continent: widget.continents[index],
          onTap: (continent) {
            widget.onContinentSelected(continent);
            _carouselController.animateToPage(
              index,
              duration: Duration(milliseconds: 500), curve: Curves.linear,
            );
          },
          selected: widget.continent == widget.continents[index],
        ),
        itemCount: widget.continents.length,
        scrollDirection: Axis.horizontal,
      ),
    );

    var summaryList = GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/1,
      ),
      children: [
        SummaryCard(
          color: Colors.grey,
          title: 'Total',
          number: widget.continent.total.toInt(),
        ),

        SummaryCard(
          color: Colors.blue,
          title: 'Confirmed',
          number: widget.continent.confirmed,
        ),
        SummaryCard(
          color: Colors.green,
          title: 'Recovered',
          number: widget.continent.recovered,
        ),
        SummaryCard(
          color: Colors.red,
          title: 'Deaths',
          number: widget.continent.deaths,
        ),

      ],
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );

    var appContent = Column(
      children: [
        SizedBox(height: 56.0),
        continentList,
        Expanded(
          child: Stack(
            children: [
              Center(
                child: summaryList,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 114.0,
                  width: 114.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: SummaryChart(
                      report: widget.continent,
                      size: 50.0,
                      showPercent: true,
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ],
    );

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 56.0,),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(height: double.infinity),
                items: widget.continents.map((i) => Builder(
                  builder: (context) => Image.asset(i.image, fit: BoxFit.fitWidth,),
                )).toList(),
                carouselController: _carouselController,
              ),
            )

          ],
        ),
        Container(
          color: Colors.orangeAccent.withOpacity(0.2),
        ),
        appContent,
      ],
    );
  }

}