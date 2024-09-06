import 'package:chat_app/core/common/widgets/chat_bubble/chat_bubble.dart';
import 'package:chat_app/core/injection/injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _firestore = getIt<FirebaseFirestore>();
  final _user = getIt<FirebaseAuth>().currentUser!;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _firestore
            .collection("chat")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Oops something wrong."),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No message found."),
            );
          }

          final _loadedMessage = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: _loadedMessage.length,
            itemBuilder: (context, index) {
              final chatMessage = _loadedMessage[index].data();
              final nextChatMessage = index + 1 < _loadedMessage.length
                  ? _loadedMessage[index + 1].data()
                  : null;

              final currentMessageUserId = chatMessage['userId'];

              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;

              final nextUserIsSame = nextMessageUserId == currentMessageUserId;

              if (nextUserIsSame) {
                return ChatBubble.next(
                    message: chatMessage['text'],
                    isMe: _user.uid == currentMessageUserId);
              } else {
                return ChatBubble.first(
                    userImage: chatMessage['userImage'],
                    username: chatMessage['username'],
                    message: chatMessage['text'],
                    isMe: _user.uid == currentMessageUserId);
              }
            },
          );
        },
      ),
    );
  }
}
