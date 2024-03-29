import 'package:dio/dio.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;

            case DioErrorType.receiveTimeout:
              errorDescription = "Receive timeout in connection with API server";
              break;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  if (error.response!.data != null && error.response!.data.length > 0) {
                    errorDescription = error.response!.data;
                  } else {
                    errorDescription = "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioErrorType.connectTimeout:
              errorDescription = "Connection timeout with API server";

              break;
            case DioErrorType.receiveTimeout:
              errorDescription = "Connection timeout with API server";
              break;

            case DioErrorType.cancel:
              errorDescription = "Connection Failed with API server";
              break;
            case DioErrorType.other:
              errorDescription = "Unknown error";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
