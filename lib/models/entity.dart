///
/// abstract model class for all model data containers to follow
///

abstract class Entity {

  Entity(this.id);

  Entity.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
  }

  String id;

}