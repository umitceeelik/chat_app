import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/features/contacts/domain/usecases/fetch_recent_contacts_usecase.dart';
import 'package:chat_app/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:chat_app/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc  extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();


  ConversationsBloc({required this.fetchConversationsUseCase}) : super(ConversationsInitial()) {
    on<FetchConversations>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _initializeSocketListeners() {
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated);
    } catch (error) {
      print("Error initializing socket listeners : $error");
    }
  }



  Future<void> _onFetchConversations(FetchConversations event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());
    try {
      final conversations = await fetchConversationsUseCase.call();
      emit(ConversationsLoaded(conversations: conversations));
    } catch (error) {
      emit(ConversationError(message: "Failed to fetch conversations"));
    }
  }

  void _onConversationUpdated(data) {
    add(FetchConversations());
  }
}