import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_chat_repository.dart';

void main() {
  late FakeChatRepository repo;

  setUp(() {
    repo = FakeChatRepository();
  });

  test('SendMessageUseCase returns Right on success', () async {
    final result = await SendMessageUseCase(repo).execute(
      content: 'hi',
      previousMessages: const [],
    );
    expect(result.isRight(), isTrue);
    expect(repo.sendCalls, 1);
  });

  test('SendMessageUseCase returns Left on repository error', () async {
    repo.sendError = 'boom';
    final result = await SendMessageUseCase(repo).execute(
      content: 'hi',
      previousMessages: const [],
    );
    expect(result, const Left<String, dynamic>('boom'));
  });

  test('SaveChatUseCase delegates to repository', () async {
    await SaveChatUseCase(repo).execute(
      ChatModel(
        id: 'c-1',
        title: 't',
        messages: const [],
        createdAt: DateTime.utc(2024, 1, 1),
      ),
    );
    expect(repo.saveCalls, 1);
    expect(repo.stored?.id, 'c-1');
  });

  test('GetChatsUseCase yields Left when no chat stored', () async {
    final result = await GetChatsUseCase(repo).execute();
    expect(result.isLeft(), isTrue);
  });

  test('GetChatsUseCase yields Right after a save', () async {
    await SaveChatUseCase(repo).execute(
      ChatModel(
        id: 'c-1',
        title: 't',
        messages: const [],
        createdAt: DateTime.utc(2024, 1, 1),
      ),
    );
    final result = await GetChatsUseCase(repo).execute();
    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('expected Right'),
      (chat) => expect(chat.id, 'c-1'),
    );
  });

  test('DeleteChatUseCase clears stored chat', () async {
    await SaveChatUseCase(repo).execute(
      ChatModel(
        id: 'c-1',
        title: 't',
        messages: const [],
        createdAt: DateTime.utc(2024, 1, 1),
      ),
    );
    await DeleteChatUseCase(repo).call();
    expect(repo.deleteCalls, 1);
    expect(repo.stored, isNull);
  });
}
