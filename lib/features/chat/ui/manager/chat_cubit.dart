import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/features/chat/data/services/chat_signalr_service.dart';
import 'package:mindecho/features/chat/domain/entities/booking_status_changed_entity.dart';
import 'package:mindecho/features/chat/domain/entities/chat_message_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatSignalRService _signalRService;
  final List<ChatMessageEntity> _messages = [];
  int? _currentBookingId;

  ChatCubit({required ChatSignalRService signalRService})
      : _signalRService = signalRService,
        super(ChatInitialState()) {
    _setupListeners();
  }

  void _setupListeners() {
    _signalRService.onReceiveMessage = (message) {
      _messages.add(message);
      emit(ChatNewMessageState(messages: List.from(_messages)));
    };

    _signalRService.onLoadMessages = (messages) {
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatMessagesLoadedState(messages: List.from(_messages)));
    };

    _signalRService.onChatSeen = () {
      emit(ChatSeenState());
    };

    _signalRService.onBookingStatusChanged = (data) {
      emit(BookingStatusChangedState(statusData: data));
    };
  }

  Future<void> initChat(int bookingId) async {
    _currentBookingId = bookingId;
    _messages.clear();
    emit(ChatConnectingState());
    try {
      await _signalRService.connect();
      await _signalRService.joinChat(bookingId);
      await _signalRService.loadMessages(bookingId);
      emit(ChatConnectedState());
    } catch (e) {
      emit(ChatErrorState(message: "Failed to connect to chat"));
    }
  }

  Future<void> sendMessage(String content) async {
    if (_currentBookingId == null || content.trim().isEmpty) return;
    try {
      await _signalRService.sendMessage(_currentBookingId!, content);
    } catch (e) {
      emit(ChatErrorState(message: "Failed to send message"));
    }
  }

  Future<void> markAsRead() async {
    if (_currentBookingId == null) return;
    await _signalRService.markAsRead(_currentBookingId!);
  }

  List<ChatMessageEntity> get messages => List.from(_messages);

  @override
  Future<void> close() async {
    await _signalRService.disconnect();
    return super.close();
  }
}
