import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  sending,
  error,
}

class AiBotState extends Equatable {
  final ChatStatus status;
  final List<ChatModel> chats;
  final ChatModel? currentChat;
  final MessageModel? lastMessage;
  final String? errorMessage;
  final bool isNewMessage;

  const AiBotState({
    this.status = ChatStatus.initial,
    this.chats = const [],
    this.currentChat,
    this.lastMessage,
    this.errorMessage,
    this.isNewMessage = false,
  });

  // Factory constructors for different states
  factory AiBotState.initial() => const AiBotState();

  factory AiBotState.loading() => const AiBotState(
        status: ChatStatus.loading,
      );

  factory AiBotState.error(String message) => AiBotState(
        status: ChatStatus.error,
        errorMessage: message,
      );

  factory AiBotState.chatsLoaded(List<ChatModel> chats) => AiBotState(
        status: ChatStatus.loaded,
        chats: chats,
      );

  factory AiBotState.chatLoaded(ChatModel chat, {bool isNewMessage = false}) =>
      AiBotState(
        status: ChatStatus.loaded,
        currentChat: chat,
        isNewMessage: isNewMessage,
      );

  factory AiBotState.messageSending() => const AiBotState(
        status: ChatStatus.sending,
      );

  factory AiBotState.messageSent(MessageModel message, ChatModel chat) =>
      AiBotState(
        status: ChatStatus.loaded,
        currentChat: chat,
        lastMessage: message,
        isNewMessage: true,
      );

  // Copy with method for creating new state instances
  AiBotState copyWith({
    ChatStatus? status,
    List<ChatModel>? chats,
    ChatModel? currentChat,
    MessageModel? lastMessage,
    String? errorMessage,
    bool? isNewMessage,
  }) {
    return AiBotState(
      status: status ?? this.status,
      chats: chats ?? this.chats,
      currentChat: currentChat ?? this.currentChat,
      lastMessage: lastMessage ?? this.lastMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      isNewMessage: isNewMessage ?? this.isNewMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        chats,
        currentChat,
        lastMessage,
        errorMessage,
        isNewMessage,
      ];
}
