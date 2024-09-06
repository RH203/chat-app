import 'package:chat_app/app_logger.dart';
import 'package:chat_app/core/injection/injection.dart';
import 'package:chat_app/src/chatscreen/presentation/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> _sendMessage() async {
    final _message = _messageController.text;
    final user = getIt<FirebaseAuth>().currentUser!;
    final firestore = getIt<FirebaseFirestore>();

    try {
      final userData = await getIt<FirebaseFirestore>()
          .collection("users")
          .doc(user.uid)
          .get();

      if (_message.trim().isEmpty) return;
      _messageController.clear();

      await firestore.collection("chat").add({
        "text": _message,
        "createdAt": Timestamp.now(),
        "userId": user.uid,
        "username": userData.data()!['fullname'],
        "userImage": userData.data()!['image_url'],
      });
    } catch (error) {
      AppLogger.error(error);
    }
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
          ChatView(),
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
