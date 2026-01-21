import 'package:flutter_mobx_mvvm_task_manager/core/utils/supabase/supabase_auth.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuth _supabaseAuth;

  AuthRepositoryImpl(this._supabaseAuth);

  @override
  Future<AuthResponse> signInWithPassword({required String email, required String password}) async {
    return await _supabaseAuth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUpWithPassword({required String email, required String password}) async {
    return await _supabaseAuth.signUpWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabaseAuth.signOut();
  }
}
