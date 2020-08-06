import 'report.dart';

class Country extends Report {
  Country({
    String id,
    this.code,
    this.name,
    this.latitude,
    this.longitude,

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

  Country.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this.code = json['code'];
    this.name = json['country'];

    this.latitude = (json['latitude'] as num).toDouble();
    this.longitude = (json['longitude'] as num).toDouble();
  }

  String code;
  String name;
  String get flag => 'https://www.countryflags.io/$code/flat/64.png';

  double latitude;
  double longitude;

}