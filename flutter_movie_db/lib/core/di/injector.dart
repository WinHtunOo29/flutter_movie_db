import 'package:dio/dio.dart';
import 'package:flutter_movie_db/core/network/dio_factory.dart';
import 'package:flutter_movie_db/features/movie_detail/movie_detail_injections.dart';
import 'package:flutter_movie_db/features/movie_list/movie_list_injections.dart';
import 'package:get_it/get_it.dart';

GetIt get getIt => GetIt.instance;

Future<void> inject() async {
  final dio = DioFactory().getDio();
  getIt.registerLazySingleton<Dio>(() => dio);

  // Feature injections
  movieListInjections();
  movieDetailInjections();
}