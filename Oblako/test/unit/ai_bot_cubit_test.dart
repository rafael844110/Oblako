import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_cubit.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_chat_repository.dart';

void main() {
  late FakeChatRepository repo;
  late AiBotCubit cubit;

  setUp(() {
    repo = FakeChatRepository();
    cubit = AiBotCubit(
      sendMessageUseCase: SendMessageUseCase(repo),
      getChatUseCase: GetChatsUseCase(repo),
      saveChatUseCase: SaveChatUseCase(repo),
      deleteChatUseCase: DeleteChatUseCase(repo),
      chatRepository: repo,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  test('initial state is initial', () {
    expect(cubit.state.status, ChatStatus.initial);
  });

  test('loadChat with no stored chat emits a new empty chat', () async {
    await cubit.loadChat();
    expect(cubit.state.status, ChatStatus.loaded);
    expect(cubit.state.currentChat, isNotNull);
    expect(cubit.state.currentChat!.messages, isEmpty);
  });

  Future<void> waitForStatus(ChatStatus s) async {
    if (cubit.state.status == s) return;
    await cubit.stream.firstWhere((st) => st.status == s);
  }

  test('sendMessage on success stores chat + emits messageSent', () async {
    cubit.sendMessage(
      chatId: 'c-1',
      content: 'hello',
      previousMessages: const [],
    );

    await waitForStatus(ChatStatus.loaded);
    expect(cubit.state.isNewMessage, isTrue);
    expect(cubit.state.lastMessage?.role, 'assistant');
    expect(repo.saveCalls, 1);
    expect(repo.stored?.messages.length, 2);
    expect(repo.stored?.messages.first.role, 'user');
  });

  test('sendMessage failure emits error state', () async {
    repo.sendError = 'network down';
    cubit.sendMessage(
      chatId: 'c-1',
      content: 'hello',
      previousMessages: const [],
    );

    await waitForStatus(ChatStatus.error);
    expect(cubit.state.errorMessage, contains('network down'));
    expect(repo.saveCalls, 0);
  });

  test('deleteCurrentChat resets to initial when chat present', () async {
    await cubit.loadChat();
    await cubit.deleteCurrentChat();
    expect(cubit.state.status, ChatStatus.initial);
    expect(repo.deleteCalls, 1);
  });
}
