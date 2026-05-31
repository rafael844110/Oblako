import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<String, MessageModel>> execute({
    required String content,
    required List<MessageModel> previousMessages,
    String modelId = "meta-llama/Llama-3.3-70B-Instruct",
    double temperature = 0.7,
  }) {
    return repository.sendMessage(
      content: content,
      previousMessages: previousMessages,
      modelId: modelId,
      temperature: temperature,
    );
  }
}
