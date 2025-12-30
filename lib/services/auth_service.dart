import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email & password
  Future<UserCredential> signIn(String email, String password) async {
    // To be implemented
    throw UnimplementedError();
  }

  // Sign up with email & password
  Future<UserCredential> signUp(String email, String password) async {
    // To be implemented
    throw UnimplementedError();
  }

  // Sign out
  Future<void> signOut() async {
    // To be implemented
    throw UnimplementedError();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
}
