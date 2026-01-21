import 'package:flutter_mobx_mvvm_task_manager/core/utils/supabase/supabase_auth.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/utils/supabase/supabase_functions.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/repository/auth_repository.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/repository/auth_repository_impl.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/viewmodel/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthModule {
  static final List<SingleChildWidget> providers = [
    _supabaseClientProvider,
    _supabaseAuthProvider,
    _supabaseFunctionsProvider,
    _authRepositoryProvider,
    _authViewModelProvider,
  ];

  static final _supabaseClientProvider = Provider<SupabaseClient>(
    create: (_) => Supabase.instance.client,
  );

  static final _supabaseAuthProvider = ProxyProvider<SupabaseClient, SupabaseAuth>(
    update: (_, client, __) => SupabaseAuth(client),
  );

  static final _supabaseFunctionsProvider = ProxyProvider<SupabaseClient, SupabaseFunctions>(
    update: (_, client, __) => SupabaseFunctions(client),
  );

  static final _authRepositoryProvider = ProxyProvider<SupabaseAuth, AuthRepository>(
    update: (_, supabaseAuth, __) => AuthRepositoryImpl(supabaseAuth),
  );

  static final _authViewModelProvider = ProxyProvider<AuthRepository, AuthViewModel>(
    update: (_, repository, __) => AuthViewModel(repository),
  );
}
