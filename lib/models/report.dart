import 'entity.dart';

class Report extends Entity {
  Report({
    String id = '',
    this.confirmed = 0,
    this.recovered = 0,
    this.deaths = 0,
    this.updateTime,
  }) : super(id);

  Report.fromJson(Map<String, dynamic> json)
      : confirmed = (json['confirmed'] as num).toInt(),
        recovered = (json['recovered'] as num).toInt(),
        deaths = (json['deaths'] as num).toInt(),
        updateTime = json['lastUpdate'] != null
            ? DateTime.parse(json['lastUpdate'])
            : null,
        super.fromJson(json);

  int confirmed;
  int recovered;
  int deaths;

  DateTime? updateTime;

  double get total => 1.0 * (confirmed + recovered + deaths);

  Map<String, dynamic> toJson() {
    return {
      'confirmed': confirmed,
      'recovered': recovered,
      'deaths': deaths,
    };
  }
}
