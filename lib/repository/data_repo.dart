import '../api_services/Dio/dio_client.dart';
import '../api_services/exception/api_error_handler.dart';
import '../model/update_token_model.dart';
import '../model/user_add_model.dart';
import '../responseApi/api_response.dart';

class DataRepo {
  final DioClient dioClient;

  DataRepo({required this.dioClient});

  Future<ApiResponse> getuser() async {
    try {
      final response = await dioClient.get('User');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> loginUser({String? username}) async {
    try {
      final response = await dioClient.post(
        'User/Login',
        data: '"$username"',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> insertUser(UserAddModel userAddModel) async {
    try {
      final response = await dioClient.post(
        'User/addUser',
        data: userAddModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateFbToken(UpdateTokenModel userAddModel, String id) async {
    try {
      final response = await dioClient.put(
        'User/$id',
        data: userAddModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
