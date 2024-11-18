import 'package:appverse/data/models/task_model.dart';
import 'package:appverse/domain/entities/task.dart';

extension TaskMapper on TaskModel {
  Task get toEntity {
    return Task(
      taskId: taskId,
      createdAt: DateTime.parse(createdAt),
      status: Status.from(status),
    );
  }
}
