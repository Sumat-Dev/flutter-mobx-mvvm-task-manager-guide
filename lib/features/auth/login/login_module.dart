import 'package:flutter_mobx_mvvm_task_manager/core/utils/supabase/supabase_auth.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/utils/supabase/supabase_functions.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/login/repository/login_repository.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/login/repository/login_repository_impl.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/login/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginModule {
  static final List<SingleChildWidget> providers = [
    _supabaseClientProvider,
    _supabaseAuthProvider,
    _supabaseFunctionsProvider,
    _authRepositoryProvider,
    _authViewModelProvider,
  ];

  static final _supabaseClientProvider =
  Provider<SupabaseClient>(
    create: (_) => Supabase.instance.client,
  );

  static final _supabaseAuthProvider =
  ProxyProvider<SupabaseClient, SupabaseAuth>(
    update: (_, client, _) => SupabaseAuth(client),
  );

  static final _supabaseFunctionsProvider =
  ProxyProvider<SupabaseClient, SupabaseFunctions>(
    update: (_, client, _) => SupabaseFunctions(client),
  );

  static final _authRepositoryProvider =
  ProxyProvider<SupabaseAuth, LoginRepository>(
    update: (_, supabaseAuth, _) => LoginRepositoryImpl(supabaseAuth),
  );

  static final _authViewModelProvider =
  ProxyProvider<LoginRepository, LoginViewModel>(
    update: (_, repository, _) => LoginViewModel(repository),
  );
}
