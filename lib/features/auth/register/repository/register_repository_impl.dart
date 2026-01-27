import 'package:flutter_mobx_mvvm_task_manager/core/utils/supabase/supabase_auth.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/register/repository/register_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._supabaseAuth);

  final SupabaseAuth _supabaseAuth;

  @override
  Future<AuthResponse> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    return _supabaseAuth.signUpWithPassword(
      email: email,
      password: password,
    );
  }
}
