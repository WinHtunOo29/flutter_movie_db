import 'package:flutter/material.dart';
import 'package:flutter_movie_db/core/navigation/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
    );
  }
}