import 'package:cullinarium/features/ai_bot/data/datasources/local/chat_local_data_source.dart';
import 'package:cullinarium/features/ai_bot/data/datasources/remote/chat_api_data_source.dart';
import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiDataSource apiDataSource;
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<String, MessageModel>> sendMessage({
    required String content,
    required List<MessageModel> previousMessages,
    String? modelId,
    double? temperature,
  }) async {
    try {
      final List<MessageModel> messageModels = previousMessages
          .map((m) => MessageModel(
                id: m.id,
                content: m.content,
                role: m.role,
                timestamp: m.timestamp,
              ))
          .toList();

      final userMessage = MessageModel(
        id: const Uuid().v4(),
        content: content,
        role: 'user',
        timestamp: DateTime.now(),
      );
      messageModels.add(userMessage);

      final response = await apiDataSource.sendMessage(
        messages: messageModels,
        model: modelId ?? "meta-llama/Llama-3.3-70B-Instruct",
        temperature: temperature ?? 0.7,
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ChatModel>> getChat() async {
    return await localDataSource.getChat();
  }

  @override
  Future<Either<String, void>> saveChat(ChatModel chat) async {
    try {
      final updatedChat = ChatModel(
        id: chat.id,
        title: chat.title,
        messages: chat.messages,
        createdAt: chat.createdAt,
        updatedAt: DateTime.now(),
      );
      await localDataSource.saveChat(updatedChat);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteChat() async {
    return await localDataSource.deleteChat();
  }
}
