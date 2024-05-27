import 'report.dart';

class Country extends Report {
  Country({
    String id = '',
    this.code = '',
    this.name = '',
    this.latitude = 0,
    this.longitude = 0,
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

  Country.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        name = json['country'],
        latitude = (json['latitude'] as num).toDouble(),
        longitude = (json['longitude'] as num).toDouble(),
        super.fromJson(json);

  String code;
  String name;
  String get flag => 'https://www.countryflags.io/$code/flat/64.png';

  double latitude;
  double longitude;
}
