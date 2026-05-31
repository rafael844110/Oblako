import 'dart:convert';
import 'package:cullinarium/features/ai_bot/data/mappers/chat_mapper.dart';
import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String _chatKey = 'io_intelligence_current_chat';

  ChatLocalDataSource(this.sharedPreferences);

  Future<Either<String, ChatModel>> getChat() async {
    final String? jsonString = sharedPreferences.getString(_chatKey);
    if (jsonString == null) {
      return const Left('No chat found');
    }
    try {
      final chat = ChatMapper.fromJson(json.decode(jsonString));
      return Right(chat);
    } catch (e) {
      return Left('Failed to parse chat: $e');
    }
  }

  Future<Either<String, void>> saveChat(ChatModel chat) async {
    try {
      await sharedPreferences.setString(
        _chatKey,
        json.encode(ChatMapper.toJson(chat)),
      );
      return const Right(null);
    } catch (e) {
      return Left('Failed to save chat: $e');
    }
  }

  Future<Either<String, void>> deleteChat() async {
    try {
      await sharedPreferences.remove(_chatKey);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete chat: $e');
    }
  }

  Future<Either<String, List<MessageModel>>> getMessages() async {
    final chatResult = await getChat();
    return chatResult.fold(
      (error) => Left(error),
      (chat) => Right(chat.messages),
    );
  }

  Future<Either<String, void>> saveMessages(List<MessageModel> messages) async {
    final chatResult = await getChat();
    return chatResult.fold(
      (error) async {
        final newChat = ChatModel(
          id: 'default_chat_id',
          title: 'Chat with Assistant',
          messages: messages,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        return await saveChat(newChat);
      },
      (currentChat) async {
        final updatedChat = ChatModel(
          id: currentChat.id,
          title: currentChat.title,
          messages: messages,
          createdAt: currentChat.createdAt,
          updatedAt: DateTime.now(),
        );
        return await saveChat(updatedChat);
      },
    );
  }

  Future<Either<String, void>> addMessage(MessageModel message) async {
    final chatResult = await getChat();
    return chatResult.fold(
      (error) async {
        final newChat = ChatModel(
          id: 'default_chat_id',
          title: 'Chat with Assistant',
          messages: [message],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        return await saveChat(newChat);
      },
      (currentChat) async {
        final updatedMessages = [...currentChat.messages, message];
        final updatedChat = ChatModel(
          id: currentChat.id,
          title: currentChat.title,
          messages: updatedMessages,
          createdAt: currentChat.createdAt,
          updatedAt: DateTime.now(),
        );
        return await saveChat(updatedChat);
      },
    );
  }
}
