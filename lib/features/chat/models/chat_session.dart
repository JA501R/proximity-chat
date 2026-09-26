import 'chat_message.dart';

class ChatSession {
  final String id;
  final String localUserId;
  final String remoteUserId;
  final DateTime startedAt;
  final List<ChatMessage> messages;

  ChatSession({
    required this.id,
    required this.localUserId,
    required this.remoteUserId,
    required this.startedAt,
    List<ChatMessage>? messages,
  }) : messages = messages ?? [];
}
