import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<String, MessageModel>> sendMessage({
    required String content,
    required List<MessageModel> previousMessages,
    String? modelId,
    double? temperature,
  });

  Future<Either<String, ChatModel>> getChat();
  Future<Either<String, void>> saveChat(ChatModel chat);
  Future<Either<String, void>> deleteChat();
}
