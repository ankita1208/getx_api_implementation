
import 'package:api_implementation/widgets/button.dart';
import 'package:api_implementation/widgets/flatButton.dart';
import 'package:api_implementation/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/AuthController.dart';
import 'Signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 70.0,
            ),
            Row(
              children: [
                const Text(
                  'Hello!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(233, 99, 108, 25),
                    fontSize: 30,
                  ),
                ),
                const SizedBox(width: 10),
                // Add some space between the text and the image
                Image.asset(
                  'assets/images/wave.png', // Replace with your image path
                  width: 50, // Set the width as needed
                  height: 50, // Set the height as needed
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              'Welcome back! You have been missed during this time.',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(248, 231, 201, 1),
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextFieldWidget(
              labelText: 'Username',
              textEditingController: userNameController,
              textInputType: TextInputType.text,
              obscureText: false,
            ),
            const SizedBox(
              height: 35,
            ),
            TextFieldWidget(
              labelText: 'Password',
              textEditingController: passwordController,
              textInputType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(
              height: 35,
            ),
            Obx(
              () => authController.isLoading.value
                  ? const CircularProgressIndicator(color: Color.fromRGBO(233, 99, 108, 25),)
                  : ButtonWidget(
                      text: 'Login',
                      onPressedButton: () {
                        authController.login(
                            userNameController.text, passwordController.text);
                      },
                    ),
            ),
            const SizedBox(
              height: 70,
            ),
            FlatButtonWidget(
                text: 'New User? Sign Up',
                onPressedButton: () {
                  print("pressed sign");
                  Get.to(() => SignupScreen());
                }),
          ],
        ),
      ),
    );
  }
}
