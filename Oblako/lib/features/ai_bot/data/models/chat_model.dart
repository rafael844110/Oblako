import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';

class ChatModel {
  final String id;
  final String title;
  final List<MessageModel> messages;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ChatModel({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
    this.updatedAt,
  });
}
