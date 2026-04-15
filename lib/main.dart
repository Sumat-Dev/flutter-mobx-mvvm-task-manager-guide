import 'package:flutter/material.dart';
import 'package:flutter_mobx_mvvm_task_manager/app/app_router.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/constants/app/app_constants.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/utils/database/hive_database_manager.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/task_module.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: TaskModule.providers,
      child: const MyApp(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDatabaseManagerImpl.instance.initialize();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: AppConstants.enLocale,
      onGenerateRoute: AppRoute.instance.generateRoute,
    );
  }
}
