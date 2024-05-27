import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kovidoverlook/collectors/continent_col.dart';
import 'package:kovidoverlook/models/country.dart';
import 'package:logger/logger.dart';

abstract class CountryCollection {
//  static List<Country> getCountries() {
//    var r = Country(
//      name: 'Vietnam',
//      code: 'VN',
//      deaths: 6,
//      confirmed: 408,
//      recovered: 365,
//      latitude: 10.1,
//      longitude: 100.1,
//      id: '1',
//    );
//    return [
//      r, r, r, r,r, r, r, r,r, r,r, r,
//    ];
//  }

  static Stream<List<Country>> getCountriesByContinentStream<T>(
    String code,
  ) async* {
    List<Country> res = [];

    var continent = ContinentCollection.getContinentByCode(code);
    var list = continent?.countries;
    for (var countryCode in list ?? []) {
      var country = await getCountryByCode(countryCode);

      if (null != country) yield res..add(country);
    }
    Logger().i('Done');
  }

  static Future<Country?> getCountryByCode(String code) async {
    var response = await http.get(
      Uri.parse(
        'https://covid-19-data.p.rapidapi.com/country/code?format=json&code=$code',
      ),
      headers: {
        "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
        "x-rapidapi-key": "8abebd2f0dmsh8d365cd4e9c3293p1de7e1jsn2a5113d8ef55",
        "useQueryString": "true",
      },
    );

    if (response.statusCode == 200) {
      try {
        return Country.fromJson(json.decode(response.body)[0]);
      } catch (e) {
        Logger().e(e);
        return null;
      }
    } else {
      throw Exception('Failed to load');
    }
  }
}
