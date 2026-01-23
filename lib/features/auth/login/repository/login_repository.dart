import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRepository {
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  });

  Future<AuthResponse> signUpWithPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
