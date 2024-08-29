import 'package:chat_app/core/injection/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getIt<FirebaseAuth>().authStateChanges(),
        builder: (context, snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.hasData) {
              context.go('/chat-screen');
            } else if (snapshot.hasError) {
              context.go('/sign-in');
            }
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
