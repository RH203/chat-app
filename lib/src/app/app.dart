import 'package:chat_app/core/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Chat app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
      ),
      routerConfig: getIt<AppRouter>().router,
    );
  }
}
