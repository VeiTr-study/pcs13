import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> _getAuthToken() async {
    final session = _supabase.auth.currentSession;
    return session?.accessToken;
  }

  Stream<List<ChatMessage>> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> sendMessage(ChatMessage message) async {
    final token = await _getAuthToken();
    if (token != null) {
      await _firestore.collection('messages').add(message.toJson());
    } else {
      throw Exception('User is not authenticated');
    }
  }
}