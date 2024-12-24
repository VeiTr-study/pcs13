import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  String? getCurrentUserName() {
    final user = _supabase.auth.currentUser;
    return user!.userMetadata?['name'];
  }
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    try {
      final response = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      return response;
    } catch (e) {
      print('Error during sign in: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmailPassword(
      String name, String email, String password) async {
    try {
      final response =
      await _supabase.auth.signUp(email: email, password: password);
      if (response == null) {
        final user = response.user;
        if (user != null) {
          await _supabase.auth.updateUser(
            UserAttributes(
              data: {
                'name': name,
              },
            ),
          );
        }
      }
      return response;
    } catch (e) {
      print('Error during sign up: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}