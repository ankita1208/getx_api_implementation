import 'package:api_implementation/apiService/api_service.dart';
import 'package:api_implementation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/AuthController.dart';
import '../widgets/button.dart';
import '../widgets/flatButton.dart';
import '../widgets/textfieldwidget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 70.0,
            ),
            const Text(
              'Join Favorite Books',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(233, 99, 108, 25),
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Unlock a World of Stories and Connect with Fellow Readers',
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
              labelText: 'Email',
              textEditingController: emailController,
              textInputType: TextInputType.emailAddress,
              obscureText: false,
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
            Obx(() {
              return authController.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Color.fromRGBO(233, 99, 108, 25))
                  : ButtonWidget(
                      text: 'Sign Up',
                      onPressedButton: () {
                        authController.signUp(
                          userNameController.text,
                          emailController.text,
                          passwordController.text,
                        );
                      },
                    );
            }),
            const SizedBox(
              height: 70,
            ),
            FlatButtonWidget(
                text: 'Already have an account? Log In',
                onPressedButton: () {
                  Get.to(
                    () => const LoginScreen(),
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
