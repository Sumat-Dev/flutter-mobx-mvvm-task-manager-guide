import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel(this.id, this.title, this.description, this.status, this.createdAt);

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? status;

  @HiveField(4)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
