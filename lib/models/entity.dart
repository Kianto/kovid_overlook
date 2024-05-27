///
/// abstract model class for all model data containers to follow
///

abstract class Entity {
  Entity(this.id);

  Entity.fromJson(Map<String, dynamic> json) : id = json['id'] as String? ?? '';

  final String id;
}
