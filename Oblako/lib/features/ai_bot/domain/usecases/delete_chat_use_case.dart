import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteChatUseCase {
  final ChatRepository chatRepository;

  DeleteChatUseCase(this.chatRepository);

  Future<Either<String, void>> call() async {
    return await chatRepository.deleteChat();
  }
}
