import 'package:supabase_flutter/supabase_flutter.dart';
import '../storage/flutter_secure_storage.dart';

class SupabaseAuth {
  final SupabaseClient _client;
  final _secureStorage = SecureStorageManager();

  SupabaseAuth(this._client);

  User? get user => _client.auth.currentUser;

  Future<String?> get accessToken async => await _secureStorage.read(key: 'accessToken');

  Future<Map<String, String>> get headers async {
    final token = await accessToken;
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
      };
    } else {
      try {
        final response = await _client.auth.refreshSession();
        if (response.session?.accessToken != null) {
          await _secureStorage.write(key: 'accessToken', value: response.session!.accessToken);
          return {
            'Authorization': 'Bearer ${response.session!.accessToken}',
          };
        }
      } catch (_) {}
      return {};
    }
  }

  Future<AuthResponse> signInWithPassword({required String email, required String password}) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.session?.accessToken != null) {
      await _secureStorage.write(key: 'accessToken', value: response.session!.accessToken);
    }
    return response;
  }

  Future<AuthResponse> signUpWithPassword({required String email, required String password}) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    if (response.session?.accessToken != null) {
      await _secureStorage.write(key: 'accessToken', value: response.session!.accessToken);
    }
    return response;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    await _secureStorage.delete(key: 'accessToken');
  }
}
