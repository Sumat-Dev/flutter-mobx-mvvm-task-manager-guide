import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {

  TaskModel(this.id, this.title, this.description, this.status, this.createdAt);

  factory TaskModel.fromJson(Map<String, dynamic> json)
  => _$TaskModelFromJson(json);
  final String? id;
  final String? title;
  final String? description;
  final String? status;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
