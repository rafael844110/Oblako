import 'package:cullinarium/core/utils/constants/app_consts.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';

class MessageMapper {
  static Map<String, dynamic> toJson(MessageModel message) {
    return {
      'id': message.id,
      'text': message.content,
      'isUser': message.role,
      'timestamp': message.timestamp.toIso8601String(),
    };
  }

  static MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      content: json['text'] as String,
      role: json['isUser'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  static Map<String, dynamic> toApiJson(MessageModel message) {
    return {
      'role': message.role,
      'content': AppConsts.aiBot + message.content,
    };
  }
}
