import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'routers/go_routers.dart';

class YapiModelApp extends StatelessWidget {
  YapiModelApp({super.key});

  final _routerConfig = GoRouter(
    routes: $appRoutes,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'YapiModel',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig:
            _routerConfig, //const HomePage(title: 'YapiModel Home Page'),
      ),
    );
  }
}
