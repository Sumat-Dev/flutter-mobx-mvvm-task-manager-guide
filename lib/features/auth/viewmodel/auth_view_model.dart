import 'package:flutter/material.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/base/model/base_view_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/constants/navigation/navigation_constants.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/auth/repository/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase extends BaseViewModel with Store {
  final AuthRepository _authRepository;

  _AuthViewModelBase(this._authRepository);

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
      final response = await _authRepository.signInWithPassword(email: email, password: password);
      if (response.user != null) {
        Navigator.of(viewModelContext).pushReplacementNamed(NavigationConstants.TASK_LIST);
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUp(String email, String password) async {
    isLoading = true;
    try {
      await _authRepository.signUpWithPassword(email: email, password: password);
      // Optional: Navigate to login or directly to task list after signup
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    try {
      await _authRepository.signOut();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
    }
  }
}
