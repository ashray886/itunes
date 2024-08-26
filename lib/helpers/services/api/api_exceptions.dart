import 'package:dio/dio.dart';

class RestAPIException implements Exception {
  RestAPIException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = dioError.message;
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
            dioError.response!.statusCode, dioError.response!.data);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String? _handleError(int? statusCode, data) {
    switch (statusCode) {
      case 400:
        message =
            "Oops! There was a problem with your request. Please check your input and try again.";
        break;
      case 401:
        message =
            "You are not authorized to access this resource. Please log in and try again.";
        break;
      case 403:
        message = "You do not have permission to access this resource.";
        break;
      case 404:
        message = "The requested resource was not found.";
        break;
      case 405:
        message =
            "This action is not allowed. Please check and try a different action.";
        break;
      case 409:
        message = "There was a conflict with your request. Please try again.";
        break;
      case 410:
        message = "The resource you are looking for is no longer available.";
        break;
      case 422:
        message =
            "There was an error with your request. Please check your input and try again.";
        break;
      case 500:
        message = "Internal server error. Please try again later.";
        break;
      default:
        message = "An unexpected error occurred. Please try again.";
    }
    return message;
  }

  @override
  String toString() => message!;
}
