import 'package:chat_app/core/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/router/router.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Chat app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.lato().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 94, 144, 231),
        ),
      ),
      routerConfig: getIt<AppRouter>().router,
    );
  }
}
