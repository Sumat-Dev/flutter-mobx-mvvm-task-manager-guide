import 'package:flutter_mobx_mvvm_task_manager/core/utils/database/hive_database_manager.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({HiveDatabaseManager? databaseManager})
    : _databaseManager = databaseManager ?? HiveDatabaseManagerImpl.instance;

  final HiveDatabaseManager _databaseManager;
  final String _boxName = 'tasks';

  @override
  Future<List<TaskModel>> getTasks({TaskStatus? status}) async {
    final tasks = await _databaseManager.getAll<TaskModel>(_boxName);

    if (status != null) {
      return tasks.where((task) => task.status == status.name).toList();
    }
    return tasks;
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final task = await _databaseManager.get<TaskModel>(_boxName, id);
    if (task == null) {
      throw Exception('Task not found');
    }
    return task;
  }

  @override
  Future<TaskModel> createTask(
    String title,
    String? description,
    TaskStatus status,
  ) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final task = TaskModel(
      id,
      title,
      description,
      status.name,
      DateTime.now().toIso8601String(),
    );

    await _databaseManager.put<TaskModel>(_boxName, id, task);
    return task;
  }

  @override
  Future<TaskModel> updateTask(
    String id, {
    String? title,
    String? description,
    TaskStatus? status,
  }) async {
    final existingTask = await getTaskById(id);
    final updatedTask = TaskModel(
      id,
      title ?? existingTask.title,
      description ?? existingTask.description,
      status?.name ?? existingTask.status,
      existingTask.createdAt,
    );

    await _databaseManager.put<TaskModel>(_boxName, id, updatedTask);
    return updatedTask;
  }

  @override
  Future<void> deleteTask(String id) async {
    await _databaseManager.delete<TaskModel>(_boxName, id);
  }
}
