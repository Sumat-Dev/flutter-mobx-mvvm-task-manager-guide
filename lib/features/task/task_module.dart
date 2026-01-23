import 'package:flutter_mobx_mvvm_task_manager/features/task/repository/task_repository.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/repository/task_repository_impl.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/viewmodel/task_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskModule {
  static List<SingleChildWidget> get providers => [
    Provider<TaskRepository>(
      create: (_) => TaskRepositoryImpl(Supabase.instance.client),
    ),
    ProxyProvider<TaskRepository, TaskViewModel>(
      update: (_, repository, _) => TaskViewModel(repository),
    ),
  ];
}
