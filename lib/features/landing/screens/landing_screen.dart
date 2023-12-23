// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigatetoLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Welcome to Whatsapp",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height / 15,
          ),
          Image.asset(
            'assets/bg.png',
            height: 340,
            width: 340,
            color: tabColor,
          ),
          SizedBox(
            height: size.height / 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Read out Privacy Policy and Click on Accept Terms and Conditions",
              style: TextStyle(color: greyColor),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              text: 'AGREE AND CONTINUE',
              onPressed: () => navigatetoLoginScreen(context)
              ),
          )
        ]),
      ),
    );
  }
}
