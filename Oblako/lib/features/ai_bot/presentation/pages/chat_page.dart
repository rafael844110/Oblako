import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_cubit.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_state.dart';
import 'package:cullinarium/features/ai_bot/presentation/widgets/fields/chat_loader_field.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatModel _currentChat;
  bool _isNewChat = true;
  late String _chatId;
  late ChatController _chatController;
  bool _waitingForResponse = false;

  late ChatUser _user;
  final ChatUser _bot = ChatUser(
    id: 'bot',
    name: 'Assistant',
  );

  @override
  void initState() {
    super.initState();

    // Initialize with default values first
    _chatId = const Uuid().v4();
    _user = ChatUser(id: 'user', name: 'You');
    _currentChat = ChatModel(
      id: _chatId,
      title: 'New Chat',
      messages: [],
      createdAt: DateTime.now(),
    );

    // Initialize chat controller with default values
    _chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: _user,
      otherUsers: [_bot],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChat();
    });
  }

  void _initializeChat() async {
    try {
      final profileState = context.read<ProfileCubit>().state;
      if (profileState is ProfileLoaded) {
        final userId = profileState.user.id;

        setState(() {
          _user = ChatUser(
            id: userId,
            name: profileState.user.name,
          );
        });

        _chatId = "${userId}_$_chatId";

        setState(() {
          _currentChat = ChatModel(
            id: _chatId,
            title: 'Chat with Cullinarium',
            messages: [],
            createdAt: DateTime.now(),
          );
        });

        _chatController.dispose();
        _chatController = ChatController(
          initialMessageList: [],
          scrollController: ScrollController(),
          currentUser: _user,
          otherUsers: [_bot],
        );

        context.read<AiBotCubit>().loadChat();
      } else {
        // For guest mode, keep the default user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Using guest chat mode')),
        );

        setState(() {
          _currentChat = ChatModel(
            id: _chatId,
            title: 'Guest Chat',
            messages: [],
            createdAt: DateTime.now(),
          );
        });

        context.read<AiBotCubit>().saveCurrentChat();
      }
    } catch (e) {
      context.read<AiBotCubit>().saveCurrentChat();
    }
  }

  List<Message> _convertToChatViewMessages(List<MessageModel> messages) {
    return messages.map((message) {
      return Message(
        id: message.id,
        message: message.content,
        createdAt: message.timestamp,
        sentBy: message.role == 'user' ? _user.id : _bot.id,
        status: message.role == 'user'
            ? MessageStatus.delivered
            : MessageStatus.read,
      );
    }).toList();
  }

  void _handleSendPressed(
      String content, ReplyMessage replyMessage, MessageType messageType) {
    if (content.trim().isEmpty) return;

    final userMessage = MessageModel(
      id: const Uuid().v4(),
      content: content,
      role: 'user',
      timestamp: DateTime.now(),
    );

    setState(() {
      _currentChat = ChatModel(
        id: _currentChat.id,
        title: _currentChat.title,
        messages: [..._currentChat.messages, userMessage],
        createdAt: _currentChat.createdAt,
        updatedAt: DateTime.now(),
      );
      _waitingForResponse = true;
    });

    context.read<AiBotCubit>().saveCurrentChat();

    context.read<AiBotCubit>().sendMessage(
          chatId: _chatId,
          content: content,
          previousMessages: _currentChat.messages
              .sublist(0, _currentChat.messages.length - 1),
        );

    _chatController.addMessage(
      Message(
        id: userMessage.id,
        message: userMessage.content,
        createdAt: userMessage.timestamp,
        sentBy: _user.id,
        status: MessageStatus.delivered,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AiBotCubit, AiBotState>(
      listener: (context, state) {
        if (state.status == ChatStatus.loaded && state.currentChat != null) {
          setState(() {
            _currentChat = state.currentChat!;
            _isNewChat = false;
            _waitingForResponse = false;
          });

          if (state.isNewMessage && state.lastMessage != null) {
            final sentBy =
                state.lastMessage!.role == 'user' ? _user.id : _bot.id;

            try {
              _chatController.addMessage(
                Message(
                  id: state.lastMessage!.id,
                  message: state.lastMessage!.content,
                  createdAt: state.lastMessage!.timestamp,
                  sentBy: sentBy,
                  status: state.lastMessage!.role == 'user'
                      ? MessageStatus.delivered
                      : MessageStatus.read,
                ),
              );
            } catch (e) {
              _initializeChatControllerWithMessages(
                  state.currentChat!.messages);
            }
          } else if (_chatController.initialMessageList.isEmpty &&
              state.currentChat!.messages.isNotEmpty) {
            _initializeChatControllerWithMessages(state.currentChat!.messages);
          }
        } else if (state.status == ChatStatus.error) {
          setState(() {
            _waitingForResponse = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        }
      },
      builder: (context, state) {
        if (state.status == ChatStatus.loading && _isNewChat) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const SizedBox(height: kToolbarHeight),
            SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      'Шеф Карри',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<AiBotCubit>().deleteCurrentChat();
                        setState(() {
                          _currentChat = ChatModel(
                            id: _chatId,
                            title: 'New Chat',
                            messages: [],
                            createdAt: DateTime.now(),
                          );
                          _isNewChat = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ChatView(
                    chatController: _chatController,
                    chatViewState: _currentChat.messages.isNotEmpty
                        ? ChatViewState.hasMessages
                        : ChatViewState.noData,
                    onSendTap: _handleSendPressed,
                    chatBackgroundConfig: const ChatBackgroundConfiguration(
                      backgroundColor: AppColors.bgColors,
                    ),
                    chatBubbleConfig: ChatBubbleConfiguration(
                      outgoingChatBubbleConfig: ChatBubble(
                        color: theme.colorScheme.primary,
                        textStyle: TextStyle(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      inComingChatBubbleConfig: ChatBubble(
                        color: AppColors.lightGrey,
                        textStyle: theme.textTheme.headlineMedium,
                      ),
                    ),
                    featureActiveConfig: const FeatureActiveConfig(
                      enableSwipeToReply: true,
                      enableSwipeToSeeTime: false,
                    ),
                    sendMessageConfig: SendMessageConfiguration(
                      textFieldConfig: TextFieldConfiguration(
                        textStyle: theme.textTheme.headlineMedium,
                        hintStyle: theme.textTheme.headlineMedium,
                        borderRadius: BorderRadius.circular(24),
                        hintText: _waitingForResponse
                            ? 'Ожидается ответ...'
                            : 'Что вас интересует...',
                        enabled: !_waitingForResponse,
                      ),
                      sendButtonIcon: const Icon(
                        Icons.send,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  if (_waitingForResponse)
                    const Positioned(
                      bottom: 70,
                      left: 0,
                      right: 0,
                      child: ChatLoaderField(),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _initializeChatControllerWithMessages(List<MessageModel> messages) {
    _chatController.dispose();
    _chatController = ChatController(
      initialMessageList: _convertToChatViewMessages(messages),
      scrollController: ScrollController(),
      currentUser: _user,
      otherUsers: [_bot],
    );
    setState(() {});
  }
}
