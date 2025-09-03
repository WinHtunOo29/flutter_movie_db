import 'package:dio/dio.dart';
import 'package:flutter_movie_db/core/error/exceptions.dart';

class AppExceptionFactory {
  static AppException fromException(dynamic exception, StackTrace? stackTrace) {
    switch (exception) {
      case DioException():
        return DioExceptionFactory.fromException(exception);
      case FormatException():
        return ParseException(exception: exception, stackTrace: stackTrace);
      case OutOfMemoryError():
      case StackOverflowError():
        return SystemException(exception: exception, stackTrace: stackTrace);
      default:
        return UnknownException(exception: exception, stackTrace: stackTrace);
    }
  }
}

class DioExceptionFactory {
  static AppException fromException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException(
            exception: exception, stackTrace: exception.stackTrace);
      case DioExceptionType.cancel:
        return CancleTokenException(
            exception: exception, stackTrace: exception.stackTrace);
      case DioExceptionType.badResponse:
        return fromBadResponse(exception);
      default:
        return UnknownException(
            exception: exception, stackTrace: exception.stackTrace);
    }
  }

  static AppException fromBadResponse(DioException exception) {
    switch (exception.response?.statusCode) {
      case 400:
        return BadRequestException(
          exception: exception,
          stackTrace: exception.stackTrace,
          message: exception.response?.data['message'] ??
              exception.response?.data['error'],
        );
      case 401:
        return UnauthorizedException(
            exception: exception, stackTrace: exception.stackTrace);
      case 403:
        return ForbiddenException(
            exception: exception, stackTrace: exception.stackTrace);
      case 404:
        return NotFoundException(
            exception: exception, stackTrace: exception.stackTrace);
      case 500:
        return InternalServerErrorException(
            exception: exception, stackTrace: exception.stackTrace);
      case 502:
      case 503:
      case 504:
        return ServiceUnavailableException(
            exception: exception, stackTrace: exception.stackTrace);
      default:
        return InternalServerErrorException(
            exception: exception, stackTrace: exception.stackTrace);
    }
  }
}