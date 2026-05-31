import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';

class SaveChatUseCase {
  final ChatRepository repository;

  SaveChatUseCase(this.repository);

  Future<void> execute(ChatModel chat) {
    return repository.saveChat(chat);
  }
}
