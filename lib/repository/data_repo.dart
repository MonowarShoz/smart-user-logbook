import '../api_services/Dio/dio_client.dart';
import '../api_services/exception/api_error_handler.dart';
import '../model/update_token_model.dart';
import '../model/user_add_model.dart';
import '../responseApi/api_response.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DataRepo {
  final DioClient dioClient;

  DataRepo({required this.dioClient});

  Future<ApiResponse> getuser() async {
    // final options = CacheOptions(
    //   store: MemCacheStore(),
    //   policy: CachePolicy.request,
    //   maxStale: const Duration(days: 1),
    // );
    try {
      final response = await dioClient.get('User');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> loginUser({required String username, required String password}) async {
    try {
      final response = await dioClient.post(
        'User/Login',
        data: {"userName": "$username", "password": "$password"},
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

  Future<ApiResponse> updateInfo(UserAddModel userAddModel, String id) async {
    try {
      final response = await dioClient.put(
        'User/updateInfo/$id',
        data: userAddModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPrayerTime() async {
    try {
      // final response = await dioClient.get('users/2');

      final response = await dioClient
          .get('http://api.aladhan.com/v1/timingsByCity/26-03-2023?city=%24Dhaka&country=%24Bangladesh&method=%242');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
