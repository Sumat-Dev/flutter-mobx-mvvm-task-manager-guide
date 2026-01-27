import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RegisterRepository{
  Future<AuthResponse> signUpWithPassword({
    required String email,
    required String password,
  });
}
