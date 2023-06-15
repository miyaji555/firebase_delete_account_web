import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

class AuthRepository {
  AuthRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }

  // ログイン
  Future signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future deleteUser() async {
    await _auth.currentUser?.delete();
  }

  Future passwordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
