import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kovidoverlook/collectors/continent_col.dart';
import 'package:kovidoverlook/models/continent.dart';
import 'package:kovidoverlook/screens/parts/home_body.dart';
import 'package:kovidoverlook/utils/constant.dart';
import 'package:kovidoverlook/widgets/animation_notifier.dart';
import 'package:provider/provider.dart';

import 'parts/home_app_bar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _animationCtrler;

  @override
  void initState() {
    super.initState();

    _animationCtrler = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      reverseDuration: Duration(milliseconds: 500),
    );
    _animationCtrler.forward();

    ContinentCollection.initCountryListIntoContinents(context);
  }

  @override
  void dispose() {
    _animationCtrler.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AnimationNotifier(_animationCtrler),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: FutureBuilder<Continent>(
        future: ContinentCollection.getContinentReport(selectingContinent?.code),
        builder: (context, snapshot) {
          selectingContinent = snapshot.data;

          return CustomScrollView(
            slivers: <Widget>[
              _buildAppbar(selectingContinent),
              _buildList(selectingContinent),
            ],
          );
        }
      )
    );

  }

  Widget _buildAppbar(Continent continent) {
    return SliverAppBar(
      backgroundColor: Colors.grey[200],
      title: Text(Constants.appName),
      floating: true,
      expandedHeight: MediaQuery.of(context).size.height * 2 / 3,
      flexibleSpace: FlexibleSpaceBar(
        background: HomeAppBar(
          continent: ContinentCollection.getContinentByCode(continent?.id),
          onContinentSelected: _onContinentSelected,
        ),
      ),
    );
  }

  Widget _buildList(Continent continent) {
    return SliverList(
      delegate: SliverChildListDelegate([
        HomeBody(continentId: continent?.id),
      ]),
    );
  }

  Continent selectingContinent;

  void _onContinentSelected(continent) => setState(() {
    selectingContinent = continent;
    if (_animationCtrler.status == AnimationStatus.completed) {
      _animationCtrler.reverse();
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        _animationCtrler.stop();
        _animationCtrler.forward();
      });
    }
  });


}
