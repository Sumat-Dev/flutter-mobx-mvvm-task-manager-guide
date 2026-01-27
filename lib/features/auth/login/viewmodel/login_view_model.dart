import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/base/model/base_view_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/constants/navigation/navigation_constants.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/login/repository/login_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_view_model.g.dart';

class LoginViewModel = LoginViewModelBase with _$LoginViewModel;

abstract class LoginViewModelBase extends BaseViewModel with Store {
  LoginViewModelBase(this._loginRepository);

  final LoginRepository _loginRepository;

  @observable
  bool isLoading = false;

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  @action
  Future<void> signIn(String email, String password) async {
    isLoading = true;
    try {
      final response = await _loginRepository.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        if (!viewModelContext.mounted) return;
        unawaited(
          Navigator.of(viewModelContext).pushReplacementNamed(
            NavigationConstants.TASK_LIST,
          ),
        );
      }
    } on Exception catch (_) {
      // Handle error
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUp(String email, String password) async {
    // isLoading = true;
    // try {
    //   await _loginRepository.signUpWithPassword(
    //     email: email,
    //     password: password,
    //   );
    //   // Optional: Navigate to login or directly to task list after signup
    // } on Exception catch (_) {
    //   // Handle error
    // } finally {
    //   isLoading = false;
    // }
  }

  @action
  Future<void> signOut() async {
    //
  }
}
