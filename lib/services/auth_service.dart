import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instância do Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FUNÇÃO DE CADASTRO
  Future<String?> register(String email, String password) async {
    try {
      // Cria usuário no Firebase
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // sucesso
    } on FirebaseAuthException catch (e) {
      return e.message; // erro do Firebase
    }
  }

  // FUNÇÃO DE LOGIN
  Future<String?> login(String email, String password) async {
    try {
      // Faz login
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // USUÁRIO ATUAL
  User? get currentUser => _auth.currentUser;
}