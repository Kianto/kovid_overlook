import 'report.dart';

class Continent extends Report {
  Continent({
    String id = '',
    this.name,
    this.image,
    this.countries,
    int confirmed = 0,
    int recovered = 0,
    int deaths = 0,
    DateTime? updateTime,
  }) : super(
          id: id,
          confirmed: confirmed,
          recovered: recovered,
          deaths: deaths,
          updateTime: updateTime,
        );

  Continent.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'];
    image = json['image'];
  }

  Continent updateReport(Map<String, dynamic> json) {
    confirmed = json['confirmed'] as int;
    recovered = json['recovered'] as int;
    deaths = json['deaths'] as int;
//    this.updateTime  = json['updateTime'];

    return this;
  }

  void addCountryCode(String countryCode) {
    countries ??= [];
    countries!.add(countryCode);
  }

  String? name;
  String? image;
  String get code => id;

  List<String>? countries;
}
