import 'package:cullinarium/core/di/injections.dart';
import 'package:cullinarium/features/ai_bot/data/datasources/local/chat_local_data_source.dart';
import 'package:cullinarium/features/ai_bot/data/datasources/remote/chat_api_data_source.dart';
import 'package:cullinarium/features/ai_bot/data/repositories/chat_repository_impl.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_cubit.dart';

void chatInjection() {
  // Data Sources
  sl.registerSingleton(
    ChatLocalDataSource(sl()),
  );

  // API Data Source
  sl.registerSingleton(
    ChatApiDataSource(),
  );

  // Repositories
  sl.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(
      apiDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use Cases
  sl.registerFactory(() => GetChatsUseCase(sl()));
  sl.registerFactory(() => SaveChatUseCase(sl()));
  sl.registerFactory(() => SendMessageUseCase(sl()));
  sl.registerFactory(() => DeleteChatUseCase(sl()));

  // Cubits
  sl.registerFactory(() => AiBotCubit(
        sendMessageUseCase: sl(),
        getChatUseCase: sl(),
        saveChatUseCase: sl(),
        deleteChatUseCase: sl(),
        chatRepository: sl(),
      ));
}
