import 'package:chat_app/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement disposez
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final _message = _messageController.text;
    if (_message.trim().isEmpty) return;
    AppLogger.debug(_message);

    _messageController.clear();
  }

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
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text("No message found"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  enableSuggestions: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    label: Text("Send a message"),
                  ),
                ),
              ),
              IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send),
              )
            ],
          )
        ],
      ),
    );
  }
}
