import 'package:flutter_mobx_mvvm_task_manager/features/home/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/home/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/home/task/repository/task_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  @override
  Future<List<TaskModel>> getTasks({TaskStatus? status}) async {
    final queryParams = <String, dynamic>{};
    if (status != null) {
      queryParams['status'] = status.name;
    }

    final response = await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.get,
      queryParameters: queryParams,
      // headers: _authHeaders, // SDK adds this automatically
    );

    final data = response.data as List<dynamic>;
    return data
        .map(
          (json) => TaskModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final response = await _supabaseClient.functions.invoke(
      'tasks',
      method: HttpMethod.get,
      queryParameters: {'id': id},
      // headers: _authHeaders,
    );

    return TaskModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<TaskModel> createTask(
    String title,
    String? description,
    TaskStatus status,
  ) async {
    final response = await _supabaseClient.functions.invoke(
      'tasks',
      body: {
        'title': title,
        'description': description,
        'status': status.name,
      },
      // headers: _authHeaders,
    );

    return TaskModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<TaskModel> updateTask(
    String id, {
    String? title,
    String? description,
    TaskStatus? status,
  }) async {
    final body = <String, dynamic>{};
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

    return TaskModel.fromJson(response.data as Map<String, dynamic>);
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
