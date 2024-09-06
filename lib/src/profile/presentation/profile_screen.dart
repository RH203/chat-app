import 'dart:io';

import 'package:chat_app/app_logger.dart';
import 'package:chat_app/core/injection/injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _pickedImageFile;
  final _user = getIt<FirebaseAuth>().currentUser;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (pickedImage == null) return;

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  Future<void> _onSaveImage() async {
    final storage = getIt<FirebaseStorage>();
    final firestore = getIt<FirebaseFirestore>();
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: LoadingAnimationWidget.beat(
              color: Colors.blueAccent,
              size: 150,
            ),
          );
        },
      );

      final ref = storage.ref().child("user_image").child("${_user!.uid}.jpg");
      await ref.putFile(_pickedImageFile!);
      final imageUrl = await ref.getDownloadURL();

      await firestore.collection("users").doc(_user.uid).set({
        "fullname": _user.displayName,
        "email": _user.email,
        "image_url": imageUrl
      });
    } on FirebaseException catch (error) {
      if (mounted) context.pop();
      AppLogger.error("FirebaseException: ${error.message}");
    } catch (error) {
      if (mounted) context.pop();
      AppLogger.error(error);
    } finally {
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = getIt<FirebaseAuth>().currentUser!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton.outlined(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton.outlined(
                onPressed: () async {
                  await getIt<FirebaseAuth>().signOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go("/sign-in");
                  });
                },
                icon: const Icon(Icons.logout_outlined),
              )
            ],
          ),
          SliverList.list(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                        future: getIt<FirebaseFirestore>()
                            .collection("users")
                            .doc(user.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.error),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            final imageUrl = snapshot.data!['image_url'];
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: imageUrl != null
                                      ? NetworkImage(imageUrl)
                                      : null,
                                  backgroundColor: Colors.grey[300],
                                  child: imageUrl == null
                                      ? const Icon(Icons.person)
                                      : null,
                                ),
                                Visibility(
                                  visible: _pickedImageFile == null &&
                                      !snapshot.hasData,
                                  child: const Text("Change Image"),
                                ),
                              ],
                            );
                          } else {
                            return CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${_user!.displayName}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _pickedImageFile != null,
        child: FloatingActionButton(
          onPressed: _onSaveImage,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
