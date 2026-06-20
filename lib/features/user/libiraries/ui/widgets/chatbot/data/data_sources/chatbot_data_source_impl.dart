import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mindecho/core/api/api_manager.dart';
import 'package:mindecho/core/api/end_points.dart';
import 'package:mindecho/core/cashe/shared_preferences_utils.dart';
import 'package:mindecho/core/errors/failures.dart';
import 'package:mindecho/core/errors/exceptions.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/data/models/chat_history_dm.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/data/models/chat_response_dm.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/entities/chat_history_entity.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/entities/chat_response_entity.dart';
import 'package:mindecho/features/user/libiraries/ui/widgets/chatbot/domain/repositories/data_source/chatbot_data_source.dart';

class ChatBotDataSourceImpl implements ChatBotDataSource {
  final ApiManager apiManager;
  ChatBotDataSourceImpl({required this.apiManager});

  String? _getToken() =>
      SharedPreferencesUtils.getData(key: 'token') as String?;

  Future<bool> _isConnected() async {
    dynamic result = await Connectivity().checkConnectivity();
    if (result is List) return !result.contains(ConnectivityResult.none);
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, ChatResponseEntity>> sendMessage(
      String message) async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.postData(
          endPoint: EndPoints.chatBotSend,
          body: {'message': message},
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(ChatResponseDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }

  @override
  Future<Either<Failures, ChatHistoryEntity>> getHistory() async {
    if (await _isConnected()) {
      try {
        var response = await apiManager.getData(
          endPoint: EndPoints.chatBotHistory,
          headers: {'Authorization': 'Bearer ${_getToken()}'},
        );
        return Right(ChatHistoryDM.fromJson(response.data));
      } catch (e) {
        return Left(ServerError(errors: handleError(e)));
      }
    }
    return Left(NetworkError(errors: "No Internet Connection"));
  }
}
