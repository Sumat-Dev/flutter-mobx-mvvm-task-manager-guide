import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks({TaskStatus? status});
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> createTask(String title, String? description, TaskStatus status);
  Future<TaskModel> updateTask(String id, {String? title, String? description, TaskStatus? status});
  Future<void> deleteTask(String id);
}
