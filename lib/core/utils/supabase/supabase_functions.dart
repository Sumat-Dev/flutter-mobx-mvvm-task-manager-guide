import 'package:supabase_flutter/supabase_flutter.dart';
import '../storage/flutter_secure_storage.dart';

class SupabaseFunctions {
  final SupabaseClient _client;
  final _secureStorage = SecureStorageManager();

  SupabaseFunctions(this._client);

  Future<String?> get accessToken async => await _secureStorage.read(key: 'accessToken');

  Future<Map<String, String>> get headers async {
    final token = await accessToken;
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
      };
    }
    return {};
  }

  /// Invokes a Supabase Edge Function.
  /// 
  /// The [functionName] is the name of the function to invoke.
  /// [body] is the payload to send to the function.
  /// [headers] are custom headers. The Authorization header is automatically added by Supabase SDK.
  /// [method] is the HTTP method to use (default is POST).
  Future<FunctionResponse> invokeFunction(
    String functionName, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    HttpMethod method = HttpMethod.post,
  }) async {
    final authHeaders = await this.headers;
    final finalHeaders = <String, String>{
      ...authHeaders,
      if (headers != null) ...headers,
    };

    return await _client.functions.invoke(
      functionName,
      body: body,
      headers: finalHeaders,
      method: method,
    );
  }
}
