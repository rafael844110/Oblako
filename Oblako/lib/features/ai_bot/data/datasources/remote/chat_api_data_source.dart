import 'package:cullinarium/core/utils/constants/api_const.dart';
import 'package:cullinarium/features/ai_bot/data/exeptions/chat_api_exeption.dart';
import 'package:cullinarium/features/ai_bot/data/mappers/message_mapper.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChatApiDataSource {
  final http.Client client;

  ChatApiDataSource({
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<MessageModel> sendMessage({
    required List<MessageModel> messages,
    String model = "meta-llama/Llama-3.3-70B-Instruct",
    double temperature = 0.7,
  }) async {
    const url = '${ApiConst.baseUrl}/chat/completions';

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConst.apiKey}',
        },
        body: jsonEncode({
          'model': model,
          'messages': messages.map((m) => MessageMapper.toApiJson(m)).toList(),
          "reasoning_content": true,
          'temperature': temperature,
        }),
      );

      print('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Parse the actual response format - adjust as needed based on API response
        final assistantMessage = data['choices'][0]['message'];

        return MessageModel(
          id: const Uuid().v4(),
          content: assistantMessage['content'],
          role: 'assistant',
          timestamp: DateTime.now(),
        );
      } else {
        throw ChatApiException(
          'Failed to get response from API',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ChatApiException) rethrow;
      throw ChatApiException('Error connecting to IO Intelligence API: $e');
    }
  }
}
