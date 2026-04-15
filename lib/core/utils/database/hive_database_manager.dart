import 'package:flutter_mobx_mvvm_task_manager/core/utils/database/hive_operation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class HiveDatabaseManager {
  Future<void> initialize();

  Future<void> clear();

  Future<void> put<T>(String boxName, String key, T value);

  Future<T?> get<T>(String boxName, String key);

  Future<List<T>> getAll<T>(String boxName);

  Future<void> delete<T>(String boxName, String key);
}

class HiveDatabaseManagerImpl implements HiveDatabaseManager {
  HiveDatabaseManagerImpl._();

  static final HiveDatabaseManagerImpl _instance = HiveDatabaseManagerImpl._();

  static HiveDatabaseManagerImpl get instance => _instance;

  @override
  Future<void> initialize() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);
  }

  @override
  Future<void> clear() async {
    await Hive.deleteFromDisk();
  }

  Future<Box<T>> _openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return Hive.openBox<T>(boxName);
  }

  @override
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await _openBox<T>(boxName);
    await HiveOperation<T>(box).addOrUpdate(key, value);
  }

  @override
  Future<T?> get<T>(String boxName, String key) async {
    final box = await _openBox<T>(boxName);
    return HiveOperation<T>(box).get(key);
  }

  @override
  Future<List<T>> getAll<T>(String boxName) async {
    final box = await _openBox<T>(boxName);
    return HiveOperation<T>(box).getAll();
  }

  @override
  Future<void> delete<T>(String boxName, String key) async {
    final box = await _openBox<T>(boxName);
    await HiveOperation<T>(box).delete(key);
  }
}
