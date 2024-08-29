import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.outlined(
            onPressed: () => context.push('/profile-screen'),
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: const Center(
        child: Text("Chat screen"),
      ),
    );
  }
}
