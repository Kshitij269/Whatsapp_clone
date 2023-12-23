import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/auth/controllers/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});
  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text("Verifying your number"),
      ),
      body: Container(
        width: size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 20,
          ),
          const Text("We have sent an SMS with a Code"),
          SizedBox(
            width: size.width * 0.5,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: '- - - - - -', hintStyle: TextStyle(fontSize: 30)),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                if (val.length == 6) {
                  verifyOTP(ref, context, val.trim());
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
