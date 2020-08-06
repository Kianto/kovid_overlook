import 'report.dart';

class Continent extends Report {
  Continent({
    String id,
    this.name,
    this.image,
    this.countries,

    int confirmed,
    int recovered,
    int deaths,
    DateTime updateTime,
  }) : super(
    id: id,
    confirmed: confirmed,
    recovered: recovered,
    deaths: deaths,
    updateTime: updateTime,
  );

  Continent.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this.name = json['name'];
    this.image = json['image'];
  }

  Continent updateReport(Map<String, dynamic> json) {
    this.confirmed = json['confirmed'] as num;
    this.recovered = json['recovered'] as num;
    this.deaths = json['deaths'] as num;
//    this.updateTime  = json['updateTime'];

    return this;
  }

  void addCountryCode(String countryCode) {
    if (null == countries) countries = [];
    countries.add(countryCode);
  }

  String name;
  String image;
  String get code => id;

  List<String> countries = [];

}