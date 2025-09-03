import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_db/core/constants/network_constants.dart';

class DioFactory {
  Dio getDio() {
    var dio = Dio();

    dio.options = BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      headers: {
         "accept": "application/json",
         "Authorization": dotenv.env['BEARER_TOKEN'],
      },
      connectTimeout: const Duration(seconds: 35),
      sendTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 60),
    );

    return dio;
  }
}