// Integration test — AI chat round-trip with a fake repository.
//
// Boots a host MaterialApp containing a minimal chat screen and verifies
// that typing a message + tapping send walks through:
//   messageSending -> messageSent (with assistant reply persisted).

import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_cubit.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

class _FakeChatRepo implements ChatRepository {
  ChatModel? store;

  @override
  Future<Either<String, MessageModel>> sendMessage({
    required String content,
    required List<MessageModel> previousMessages,
    String? modelId,
    double? temperature,
  }) async {
    return Right(MessageModel(
      id: 'reply',
      content: 'Echo: $content',
      role: 'assistant',
      timestamp: DateTime.utc(2024, 1, 1),
    ));
  }

  @override
  Future<Either<String, ChatModel>> getChat() async =>
      store == null ? const Left('none') : Right(store!);

  @override
  Future<Either<String, void>> saveChat(ChatModel chat) async {
    store = chat;
    return const Right(null);
  }

  @override
  Future<Either<String, void>> deleteChat() async {
    store = null;
    return const Right(null);
  }
}

class _ChatScreen extends StatefulWidget {
  const _ChatScreen();
  @override
  State<_ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<_ChatScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: BlocBuilder<AiBotCubit, AiBotState>(
        builder: (_, state) {
          final messages = state.currentChat?.messages ?? const [];
          return Column(
            children: [
              Expanded(
                child: ListView(
                  key: const Key('messages'),
                  children: [
                    for (final m in messages)
                      ListTile(title: Text('${m.role}: ${m.content}')),
                  ],
                ),
              ),
              if (state.status == ChatStatus.sending)
                const LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: const Key('input'),
                        controller: controller,
                      ),
                    ),
                    IconButton(
                      key: const Key('send'),
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isEmpty) return;
                        context.read<AiBotCubit>().sendMessage(
                              chatId: 'chat-1',
                              content: text,
                              previousMessages: messages,
                            );
                        controller.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('send message -> assistant reply appears in list', (tester) async {
    final repo = _FakeChatRepo();
    final cubit = AiBotCubit(
      sendMessageUseCase: SendMessageUseCase(repo),
      getChatUseCase: GetChatsUseCase(repo),
      saveChatUseCase: SaveChatUseCase(repo),
      deleteChatUseCase: DeleteChatUseCase(repo),
      chatRepository: repo,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const _ChatScreen()),
      ),
    );

    await tester.enterText(find.byKey(const Key('input')), 'hello bot');
    await tester.tap(find.byKey(const Key('send')));
    await tester.pumpAndSettle();

    expect(find.text('user: hello bot'), findsOneWidget);
    expect(find.text('assistant: Echo: hello bot'), findsOneWidget);
    expect(repo.store, isNotNull);
    expect(repo.store!.messages.length, 2);
  });
}
