import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_history_entity.dart';
import '../entities/chat_response_entity.dart';
import '../repositories/chatbot_repository.dart';

class ChatBotUseCase {
  final ChatBotRepository chatBotRepository;
  ChatBotUseCase({required this.chatBotRepository});

  Future<Either<Failures, ChatResponseEntity>> sendMessage(String message) =>
      chatBotRepository.sendMessage(message);

  Future<Either<Failures, ChatHistoryEntity>> getHistory() =>
      chatBotRepository.getHistory();
}
