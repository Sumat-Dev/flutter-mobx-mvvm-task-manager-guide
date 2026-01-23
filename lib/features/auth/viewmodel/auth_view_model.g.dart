// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$AuthViewModel on _AuthViewModelBase, Store {
  late final _$isLoadingAtom = Atom(
    name: '_AuthViewModelBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$signInAsyncAction = AsyncAction(
    '_AuthViewModelBase.signIn',
    context: context,
  );

  @override
  Future<void> signIn(String email, String password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  late final _$signUpAsyncAction = AsyncAction(
    '_AuthViewModelBase.signUp',
    context: context,
  );

  @override
  Future<void> signUp(String email, String password) {
    return _$signUpAsyncAction.run(() => super.signUp(email, password));
  }

  late final _$signOutAsyncAction = AsyncAction(
    '_AuthViewModelBase.signOut',
    context: context,
  );

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  @override
  String toString() {
    return '''
        isLoading: $isLoading
           ''';
  }
}
