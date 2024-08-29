import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (pickedImage == null) return;

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton.outlined(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          SliverList.list(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _pickedImageFile != null
                            ? FileImage(_pickedImageFile!)
                            : null,
                      ),
                      Visibility(
                        visible: _pickedImageFile == null,
                        child: const Text("Change Image"),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Raihan Firdaus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
