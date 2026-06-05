import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/chat_history_entity.dart';
import '../../entities/chat_response_entity.dart';

abstract class ChatBotDataSource {
  Future<Either<Failures, ChatResponseEntity>> sendMessage(String message);
  Future<Either<Failures, ChatHistoryEntity>> getHistory();
}
