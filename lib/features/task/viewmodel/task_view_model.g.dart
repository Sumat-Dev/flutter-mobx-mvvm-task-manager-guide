// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$TaskViewModel on _TaskViewModelBase, Store {
  late final _$tasksAtom = Atom(
    name: '_TaskViewModelBase.tasks',
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
    name: '_TaskViewModelBase.isLoading',
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
    name: '_TaskViewModelBase.errorMessage',
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
    '_TaskViewModelBase.getTasks',
    context: context,
  );

  @override
  Future<void> getTasks({TaskStatus? status}) {
    return _$getTasksAsyncAction.run(() => super.getTasks(status: status));
  }

  late final _$createTaskAsyncAction = AsyncAction(
    '_TaskViewModelBase.createTask',
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
    '_TaskViewModelBase.updateTask',
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
    '_TaskViewModelBase.deleteTask',
    context: context,
  );

  @override
  Future<void> deleteTask(String id) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(id));
  }

  @override
  String toString() {
    return '''
      tasks: $tasks,
      isLoading: $isLoading,
      errorMessage: $errorMessage
          ''';
  }
}
