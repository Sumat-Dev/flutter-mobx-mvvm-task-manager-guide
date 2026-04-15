import 'package:flutter/material.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/constants/navigation/navigation_constants.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/view/task_detail_view.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/view/task_list_view.dart';

class AppRoute {
  AppRoute._init();

  static final AppRoute _instance = AppRoute._init();

  static AppRoute get instance => _instance;

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.DEFAULT:
        return _pageBuilder((_) => const TaskListView(), settings: settings);
      case NavigationConstants.TASK_LIST:
        return _pageBuilder((_) => const TaskListView(), settings: settings);
      case NavigationConstants.TASK_DETAIL:
        return _pageBuilder((_) => const TaskDetailView(), settings: settings);
      default:
        return _pageBuilder((_) => const Scaffold(), settings: settings);
    }
  }

  PageRouteBuilder<dynamic> _pageBuilder(
    Widget Function(BuildContext) page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, _, _) => page(context),
    );
  }
}
