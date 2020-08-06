import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kovidoverlook/collectors/country_col.dart';
import 'package:kovidoverlook/models/country.dart';
import 'package:kovidoverlook/widgets/country_card.dart';
import 'package:shimmer/shimmer.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key key, @required this.continentId})
      : super(key: key);

  final String continentId;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    if (null == continentId) return SizedBox();

    return StreamBuilder<List<Country>>(
      stream: CountryCollection.getCountriesByContinentStream(continentId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              padding: const EdgeInsets.only(top: 36),
              child: _buildShimmerList(),

            ),
            enabled: true,
            direction: ShimmerDirection.rtl,
          );
        }

        var countries = snapshot.data;
        return Container(
          padding: const EdgeInsets.only(top: 36, bottom: 8.0,),
          child: ListView.separated(
            separatorBuilder: (context, _) => Divider(color: Colors.white,),
            itemCount: countries.length,
            itemBuilder: (context, index) => CountryCard(
              country: countries[index],
              onTap: (country) {},
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          decoration: BoxDecoration(
//            borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(30),
//              topRight: Radius.circular(30),
//            ),
            color: Colors.orangeAccent,
          ),
        );
      },
    );


  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemBuilder: (_, __) => ListTile(
        leading: Container(
          width: 48.0,
          height: 48.0,
          color: Colors.white,
        ),
        trailing: Container(
          width: 48.0,
          height: 48.0,
          color: Colors.white,
        ),
        title: Container(
          width: double.infinity,
          height: 8.0,
          color: Colors.white,
        ),
        subtitle: Container(
          width: 40.0,
          height: 8.0,
          color: Colors.white,
        ),
      ),
      itemCount: 6,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

}