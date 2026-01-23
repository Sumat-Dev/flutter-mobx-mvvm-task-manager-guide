// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskViewModel on TaskViewModelBase, Store {
  late final _$tasksAtom = Atom(
    name: 'TaskViewModelBase.tasks',
    context: context,
  );

  @override
  ObservableList<TaskModel> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TaskModel> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'TaskViewModelBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'TaskViewModelBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getTasksAsyncAction = AsyncAction(
    'TaskViewModelBase.getTasks',
    context: context,
  );

  @override
  Future<void> getTasks({TaskStatus? status}) {
    return _$getTasksAsyncAction.run(() => super.getTasks(status: status));
  }

  late final _$createTaskAsyncAction = AsyncAction(
    'TaskViewModelBase.createTask',
    context: context,
  );

  @override
  Future<void> createTask(
    String title,
    String? description,
    TaskStatus status,
  ) {
    return _$createTaskAsyncAction.run(
      () => super.createTask(title, description, status),
    );
  }

  late final _$updateTaskAsyncAction = AsyncAction(
    'TaskViewModelBase.updateTask',
    context: context,
  );

  @override
  Future<void> updateTask(
    String id, {
    String? title,
    String? description,
    TaskStatus? status,
  }) {
    return _$updateTaskAsyncAction.run(
      () => super.updateTask(
        id,
        title: title,
        description: description,
        status: status,
      ),
    );
  }

  late final _$deleteTaskAsyncAction = AsyncAction(
    'TaskViewModelBase.deleteTask',
    context: context,
  );

  @override
  Future<void> deleteTask(String id) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(id));
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
