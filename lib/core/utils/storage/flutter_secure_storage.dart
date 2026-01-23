import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  factory SecureStorageManager() => _instance;
  SecureStorageManager._init();
  static final SecureStorageManager _instance = SecureStorageManager._init();

  final _storage = const FlutterSecureStorage();

  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return _storage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
