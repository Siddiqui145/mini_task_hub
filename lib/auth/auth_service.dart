import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signup(String email, String password) async {
    try {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password);

      return result.user;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.message);
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try{
      final result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);

        return result.user;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}