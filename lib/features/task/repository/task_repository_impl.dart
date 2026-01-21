import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/repository/task_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SupabaseClient _supabaseClient;

  TaskRepositoryImpl(this._supabaseClient);

  @override
  Future<List<TaskModel>> getTasks({TaskStatus? status}) async {
    final Map<String, dynamic> queryParams = {};
    if (status != null) {
      queryParams['status'] = status.name;
    }

    final response = await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.get,
      queryParameters: queryParams,
      // headers: _authHeaders, // SDK adds this automatically
    );

    final List<dynamic> data = response.data;
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final response = await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.get,
      queryParameters: {'id': id},
      // headers: _authHeaders,
    );

    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> createTask(String title, String? description, TaskStatus status) async {
    final response = await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.post,
      body: {
        'title': title,
        'description': description,
        'status': status.name,
      },
      // headers: _authHeaders,
    );

    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask(String id, {String? title, String? description, TaskStatus? status}) async {
    final Map<String, dynamic> body = {};
    if (title != null) body['title'] = title;
    if (description != null) body['description'] = description;
    if (status != null) body['status'] = status.name;

    final response = await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.patch,
      queryParameters: {'id': id},
      body: body,
      // headers: _authHeaders,
    );

    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.delete,
      queryParameters: {'id': id},
      // headers: _authHeaders,
    );
  }
}
