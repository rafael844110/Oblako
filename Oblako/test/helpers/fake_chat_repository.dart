import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class FakeChatRepository implements ChatRepository {
  ChatModel? stored;

  String? sendError;
  MessageModel sendReply = MessageModel(
    id: 'reply-1',
    content: 'Hello, human.',
    role: 'assistant',
    timestamp: DateTime.utc(2024, 1, 1),
  );

  int sendCalls = 0;
  int saveCalls = 0;
  int deleteCalls = 0;

  @override
  Future<Either<String, MessageModel>> sendMessage({
    required String content,
    required List<MessageModel> previousMessages,
    String? modelId,
    double? temperature,
  }) async {
    sendCalls++;
    if (sendError != null) return Left(sendError!);
    return Right(sendReply);
  }

  @override
  Future<Either<String, ChatModel>> getChat() async {
    if (stored == null) return const Left('not found');
    return Right(stored!);
  }

  @override
  Future<Either<String, void>> saveChat(ChatModel chat) async {
    saveCalls++;
    stored = chat;
    return const Right(null);
  }

  @override
  Future<Either<String, void>> deleteChat() async {
    deleteCalls++;
    stored = null;
    return const Right(null);
  }
}
