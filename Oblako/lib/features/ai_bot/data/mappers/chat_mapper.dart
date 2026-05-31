import 'package:cullinarium/features/ai_bot/data/mappers/message_mapper.dart';
import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';

class ChatMapper {
  static Map<String, dynamic> toJson(ChatModel chat) {
    return {
      'id': chat.id,
      'name': chat.title,
      'messages': chat.messages
          .map((message) => MessageMapper.toJson(message))
          .toList(),
      'createdAt': chat.createdAt.toIso8601String(),
      'updatedAt': chat.updatedAt?.toIso8601String(),
    };
  }

  static ChatModel fromJson(dynamic json) {
    return ChatModel(
      id: json['id'] as String,
      title: json['name'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((message) => MessageMapper.fromJson(message))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}
