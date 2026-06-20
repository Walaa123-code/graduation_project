import 'package:dartz/dartz.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/entities/chat_history_entity.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/entities/chat_response_entity.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/repositories/data_source/chatbot_data_source.dart';

class ChatBotRepositoryImpl implements ChatBotRepository {
  final ChatBotDataSource chatBotDataSource;
  ChatBotRepositoryImpl({required this.chatBotDataSource});

  @override
  Future<Either<Failures, ChatResponseEntity>> sendMessage(
      String message) async {
    var either = await chatBotDataSource.sendMessage(message);
    return either.fold((e) => left(e), (r) => right(r));
  }

  @override
  Future<Either<Failures, ChatHistoryEntity>> getHistory() async {
    var either = await chatBotDataSource.getHistory();
    return either.fold((e) => left(e), (r) => right(r));
  }
}
