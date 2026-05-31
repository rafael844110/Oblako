import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  Future<Either<String, ChatModel>> execute() {
    return repository.getChat();
  }
}
