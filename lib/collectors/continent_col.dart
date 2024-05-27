import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kovidoverlook/models/continent.dart';
import 'package:kovidoverlook/utils/constant.dart';

abstract class ContinentCollection {
  static List<Continent>? _continents;

  static List<Continent> getContinents() {
    _continents ??= [
      Continent(
        name: 'WORLD',
        image: 'assets/images/world.jpg',
        id: '*',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
      Continent(
        name: 'Africa',
        image: 'assets/images/c_af.png',
        id: 'AF',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
      Continent(
        name: 'Asia',
        image: 'assets/images/c_as.png',
        id: 'AS',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
      Continent(
        name: 'Europe',
        image: 'assets/images/c_eu.png',
        id: 'EU',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
      Continent(
        name: 'North america',
        image: 'assets/images/c_na.png',
        id: 'NA',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
      Continent(
        name: 'South america',
        image: 'assets/images/c_sa.png',
        id: 'SA',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
      Continent(
        name: 'Oceania',
        image: 'assets/images/c_oc.png',
        id: 'OC',
        deaths: 0,
        confirmed: 0,
        recovered: 0,
      ),
    ];
    return _continents ?? [];
  }

  static Future<void> initCountryListIntoContinents(
    BuildContext context,
  ) async {
    var jsonData = json.decode(
      await DefaultAssetBundle.of(context).loadString(Constants.jCountryData),
    );
    List documents = jsonData as List;

    for (final data in documents) {
      var continent = getContinentByCode(data['Continent_Code']);

      if (null == continent) continue;
      // else
      getContinentByCode(data['*'])
          ?.addCountryCode(data['Two_Letter_Country_Code']);
      continent.addCountryCode(data['Two_Letter_Country_Code']);
    }
  }

  static Continent? getContinentByCode(String? code) {
    if (null == code) return getContinents().first;

    return getContinents().firstWhereOrNull((element) => element.code == code);
  }

  static Future<Continent> _getTotal() async {
    final response = await http.get(
      Uri.parse('https://covid-19-data.p.rapidapi.com/totals?format=json'),
      headers: {
        "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
        "x-rapidapi-key": "8abebd2f0dmsh8d365cd4e9c3293p1de7e1jsn2a5113d8ef55",
        "useQueryString": "true",
      },
    );

    if (response.statusCode == 200) {
      return getContinents().first.updateReport(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<Continent> getContinentReport(String? code) {
    if (null == code || '*' == code) return _getTotal();

    return Future.value(getContinentByCode(code));
  }
}
