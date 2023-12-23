import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context,
          '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Phone Number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                "Whatsapp will need to verify your phone number",
                style: TextStyle(color: greyColor, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: pickCountry,
                  child: Text(
                    "Pick Country",
                    style: TextStyle(color: Colors.blue),
                  )),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(hintText: "Phone Number"),
                    ),
                  )
                ],
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                width: 90,
                child: CustomButton(
                    text: "NEXT",
                    onPressed: () {
                      sendPhoneNumber();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
