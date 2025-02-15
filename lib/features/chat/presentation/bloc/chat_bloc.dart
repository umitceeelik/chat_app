import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/fetch_messages_usecase.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>{
  final FetchMessagesUsecase fetchMessagesUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();
  
  
  ChatBloc({required this.fetchMessagesUseCase}): super(ChatLoadingState()){
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessages);
    on<ReceiveMessageEvent>(_onReceiveMessages);
  }

  Future<void> _onLoadMessages(LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      final messages = await fetchMessagesUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(messages)));

      _socketService.socket.off('newMessage');

      _socketService.socket.emit('joinConversation', event.conversationId);
      _socketService.socket.on('newMessage', (data) {
        print("step1 - receive : $data");
        add(ReceiveMessageEvent(data));
      });
    } catch (error) {
      emit(ChatErrorState("Failed to load messages"));
    }
  }

  Future<void> _onSendMessages(SendMessageEvent event, Emitter<ChatState> emit) async {
    String userId = await _storage.read(key: 'userId') ?? '';
    print('userId: $userId');

    final newMessage = { 
      'conversationId': event.conversationId,
      'content': event.content,
      'senderId': userId
    };

    _socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> _onReceiveMessages(ReceiveMessageEvent event, Emitter<ChatState> emit) async {
    print("step2 - receive event called");
    print(event.message);
    
    final message = MessageEntity(
      id: event.message['id'],
      conversationId: event.message['conversation_id'],
      senderId: event.message['sender_id'],
      content: event.message['content'],
      createdAt: event.message['created_at'],
    );

    _messages.add(message);
    emit(ChatLoadedState(List.from(_messages)));
  }
}