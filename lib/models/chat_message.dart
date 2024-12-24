import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderEmail;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      senderEmail: json['senderEmail'],
      message: json['message'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}