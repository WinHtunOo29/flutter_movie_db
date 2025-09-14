import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/core/di/injector.dart';
import 'package:flutter_movie_db/core/navigation/app_router.dart';
import 'package:flutter_movie_db/features/movie_list/presenter/bloc/movie_list_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => getIt<MovieListBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}