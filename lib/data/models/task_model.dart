import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable(createToJson: false)
final class TaskModel {
  @JsonKey(name: 'task_id')
  final String taskId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String status;

  TaskModel({
    required this.taskId,
    required this.createdAt,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return _$TaskModelFromJson(json);
  }
}
