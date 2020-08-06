import 'entity.dart';

class Report extends Entity {
  Report({
    String id,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.updateTime,
  }) : super(id);

  Report.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this.confirmed = (json['confirmed'] as num).toInt();
    this.recovered = (json['recovered'] as num).toInt();
    this.deaths = (json['deaths'] as num).toInt();

//    this.updateTime = json['updateTime'];
  }

  int confirmed;
  int recovered;
  int deaths;

  DateTime updateTime;

  double get total => 1.0 * (confirmed + recovered + deaths);

  Map<String, dynamic> toJson() {
    return {
      'confirmed': confirmed,
      'recovered': recovered,
      'deaths': deaths,
    };
  }

}