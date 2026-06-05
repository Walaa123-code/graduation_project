import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_history_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_response_entity.dart';
import '../../domain/use_cases/chatbot_use_case.dart';

part 'chatbot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotUseCase chatBotUseCase;

  // قائمة الرسائل المحلية للعرض الفوري
  final List<ChatMessageEntity> messages = [];

  ChatBotCubit({required this.chatBotUseCase}) : super(ChatBotInitialState());

  Future<void> getHistory() async {
    emit(ChatHistoryLoadingState());
    var either = await chatBotUseCase.getHistory();
    either.fold(
      (error) => emit(ChatHistoryErrorState(failures: error)),
      (response) {
        messages.clear();
        messages.addAll(response.data ?? []);
        emit(ChatHistorySuccessState(historyEntity: response));
      },
    );
  }

  Future<void> sendMessage(String message) async {
    // أضيف رسالة الـ user فوراً
    messages.add(ChatMessageEntity(
      sender: 'User',
      content: message,
      createdAt: DateTime.now().toIso8601String(),
    ));
    emit(SendMessageLoadingState());

    var either = await chatBotUseCase.sendMessage(message);
    either.fold(
      (error) => emit(SendMessageErrorState(failures: error)),
      (response) {
        // أضيف رد الـ bot
        if (response.data?.reply != null) {
          messages.add(ChatMessageEntity(
            sender: 'Bot',
            content: response.data!.reply,
            createdAt: DateTime.now().toIso8601String(),
          ));
        }
        emit(SendMessageSuccessState(responseEntity: response));
      },
    );
  }
}
