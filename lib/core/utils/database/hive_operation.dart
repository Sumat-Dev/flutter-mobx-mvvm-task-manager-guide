import 'package:hive/hive.dart';

class HiveOperation<T> {
  HiveOperation(this.box);

  final Box<T> box;

  Future<void> add(T item) async {
    await box.add(item);
  }

  Future<void> addOrUpdate(dynamic key, T item) async {
    await box.put(key, item);
  }

  T? get(dynamic key) {
    return box.get(key);
  }

  List<T> getAll() {
    return box.values.toList();
  }

  Future<void> delete(dynamic key) async {
    await box.delete(key);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
