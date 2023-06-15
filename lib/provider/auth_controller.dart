import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/auth_repository.dart';
import '../util/scaffold_messanger.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, User?>(
  (ref) => AuthController(ref.read(authRepositoryProvider), ref),
);

class AuthController extends StateNotifier<User?> {
  AuthController(this.authRepository, this.ref) : super(null);
  final AuthRepository authRepository;
  final AutoDisposeStateNotifierProviderRef ref;

  @override
  User? get state => authRepository.getCurrentUser();

  Future<void> signIn(
      {required String email,
      required String password,
      required Function onCompleted}) async {
    try {
      _checkInputText(email, password);
      await authRepository.signInWithEmailAndPassword(email, password);
      onCompleted();
    } on String catch (text) {
      ref
          .watch(scaffoldMessengerHelperProvider)
          .showSnackBar(text, isWarningMessage: true);
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'user-not-found' => 'ユーザが見つかりませんでした。',
        'wrong-password' => 'パスワードが間違っています。',
        _ => 'ログインに失敗しました。',
      };
      ref
          .watch(scaffoldMessengerHelperProvider)
          .showSnackBar(message, isWarningMessage: true);
    } catch (e) {
      ref
          .watch(scaffoldMessengerHelperProvider)
          .showSnackBar(e.toString(), isWarningMessage: true);
    }
  }

  _checkInputText(String email, String password) {
    if (!EmailValidator.validate(email)) {
      throw 'emailの形式が不適切です。';
    }
    if (password.length < 6) {
      throw 'パスワードは6文字以上にしてください。';
    }
  }
}
