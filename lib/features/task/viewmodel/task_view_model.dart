import 'package:flutter/material.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/base/model/base_view_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/repository/task_repository.dart';
import 'package:mobx/mobx.dart';

part 'task_view_model.g.dart';

class TaskViewModel = _TaskViewModelBase with _$TaskViewModel;

abstract class _TaskViewModelBase extends BaseViewModel with Store {
  _TaskViewModelBase(this._taskRepository);

  final TaskRepository _taskRepository;

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  Future<void> init() async {
    await getTasks();
  }

  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> getTasks({TaskStatus? status}) async {
    isLoading = true;
    errorMessage = null;
    try {
      final taskList = await _taskRepository.getTasks(status: status);
      tasks = ObservableList.of(taskList);
    } on Exception catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createTask(
    String title,
    String? description,
    TaskStatus status,
  ) async {
    isLoading = true;
    try {
      await _taskRepository.createTask(title, description, status);
      await getTasks();
    } on Exception catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateTask(
    String id, {
    String? title,
    String? description,
    TaskStatus? status,
  }) async {
    isLoading = true;
    try {
      await _taskRepository.updateTask(
        id,
        title: title,
        description: description,
        status: status,
      );
      await getTasks();
    } on Exception catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteTask(String id) async {
    isLoading = true;
    try {
      await _taskRepository.deleteTask(id);
      await getTasks();
    } on Exception catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
