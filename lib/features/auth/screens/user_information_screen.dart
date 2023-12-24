// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controllers/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    File? selectedImage = await pickImageFromGallery(context);
    setState(() {
      image = selectedImage;
    });
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(
          context,
          name, 
          image);
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Stack(
                children: [
                  image == null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://avatars2.githubusercontent.com/u/43018659?s=4&v=4",
                          ),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 64,
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Enter Your Name"),
                    ),
                  ),
                  IconButton(
                      onPressed: storeUserData,
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      )),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
