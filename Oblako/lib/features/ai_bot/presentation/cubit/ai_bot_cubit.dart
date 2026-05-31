import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AiBotCubit extends Cubit<AiBotState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetChatsUseCase getChatUseCase;
  final SaveChatUseCase saveChatUseCase;
  final DeleteChatUseCase deleteChatUseCase;
  final ChatRepository chatRepository;

  AiBotCubit({
    required this.sendMessageUseCase,
    required this.getChatUseCase,
    required this.saveChatUseCase,
    required this.deleteChatUseCase,
    required this.chatRepository,
  }) : super(AiBotState.initial());

  // Send a message to the AI
  Future<void> sendMessage({
    required String chatId,
    required String content,
    required List<MessageModel> previousMessages,
    String? modelId,
    double? temperature,
  }) async {
    emit(AiBotState.messageSending());

    final assistantResult = await sendMessageUseCase.execute(
      content: content,
      previousMessages: previousMessages,
      modelId: modelId ?? "meta-llama/Llama-3.3-70B-Instruct",
      temperature: temperature ?? 0.7,
    );

    assistantResult.fold(
      (error) => emit(AiBotState.error('Failed to send message: $error')),
      (assistantMessage) async {
        // Get the current chat
        final chatResult = await getChatUseCase.execute();

        chatResult.fold(
          (error) async {
            // If chat not found, create a new one (shouldn't happen in your case)
            final userMessage = MessageModel(
              id: const Uuid().v4(),
              content: content,
              role: 'user',
              timestamp: DateTime.now(),
            );
            final newChat = ChatModel(
              id: chatId,
              title: _generateChatTitle(content),
              messages: [userMessage, assistantMessage],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            await saveChatUseCase.execute(newChat);
            emit(AiBotState.messageSent(assistantMessage, newChat));
          },
          (existingChat) async {
            // Update the chat with the new message
            final userMessage = MessageModel(
              id: const Uuid().v4(),
              content: content,
              role: 'user',
              timestamp: DateTime.now(),
            );

            final updatedMessages = [
              ...existingChat.messages,
              userMessage,
              assistantMessage
            ];

            final updatedChat = ChatModel(
              id: existingChat.id,
              title: existingChat.title,
              messages: updatedMessages,
              createdAt: existingChat.createdAt,
              updatedAt: DateTime.now(),
            );

            await saveChatUseCase.execute(updatedChat);
            emit(AiBotState.messageSent(assistantMessage, updatedChat));
          },
        );
      },
    );
  }

  // Load a specific chat
  Future<void> loadChat() async {
    emit(AiBotState.loading());

    final chatResult = await getChatUseCase.execute();

    chatResult.fold(
      (error) {
        final newChat = ChatModel(
          id: const Uuid().v4(),
          title: 'New Chat',
          messages: [],
          createdAt: DateTime.now(),
        );
        emit(AiBotState.chatLoaded(newChat));
      },
      (chat) {
        emit(AiBotState.chatLoaded(chat));
      },
    );
  }

  // Create a new chat (if still needed)
  Future<void> createChat({String title = 'New Chat'}) async {
    final chatId = const Uuid().v4();
    final newChat = ChatModel(
      id: chatId,
      title: title,
      messages: [],
      createdAt: DateTime.now(),
    );

    try {
      await saveChatUseCase.execute(newChat);
      emit(AiBotState.chatLoaded(newChat));
    } catch (e) {
      emit(AiBotState.error('Failed to create chat: $e'));
    }
  }

  // Save the current chat
  Future<void> saveCurrentChat() async {
    if (state.currentChat == null) return;

    try {
      await saveChatUseCase.execute(state.currentChat!);
      emit(state.copyWith()); // Just to trigger a rebuild
    } catch (e) {
      emit(AiBotState.error('Failed to save chat: $e'));
    }
  }

  // Delete the current chat
  Future<void> deleteCurrentChat() async {
    if (state.currentChat == null) return;

    try {
      await deleteChatUseCase.call();
      emit(AiBotState.initial());
    } catch (e) {
      emit(AiBotState.error('Failed to delete chat: $e'));
    }
  }

  // Helper method to generate a chat title
  String _generateChatTitle(String content) {
    final shortContent =
        content.length > 20 ? '${content.substring(0, 20)}...' : content;
    return shortContent;
  }
}
