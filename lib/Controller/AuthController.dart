import 'dart:convert';

import 'package:api_implementation/apiService/api_service.dart';
import 'package:api_implementation/screens/Home.dart';
import 'package:get/get.dart';

import '../Utilities/SharedPrefUtils.dart';
import '../Utilities/SnackbarUtil.dart';
import '../screens/login.dart';

class AuthController extends GetxController {
  ApiService apiService = ApiService();
  var isLoading = false.obs;

  void signUp(String username, String email, String password) async {
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      SnackbarUtil.showSnackBar(Get.context!, "Please fill in all fields");
      return;
    }

    try {
      isLoading(true);
      final response = await apiService.signUp(username, email, password);
      if (response.statusCode == 200) {
        SnackbarUtil.showSnackBar(Get.context!, "Sign up successful!");
        Get.offAll(() => const LoginScreen());
      } else {
        SnackbarUtil.showSnackBar(Get.context!, "Failed to  signup");
      }
    } catch (e) {
      SnackbarUtil.showSnackBar(Get.context!, 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      SnackbarUtil.showSnackBar(Get.context!, "Please fill in all fields");
      return;
    }

    try {
      isLoading(true);
      final response = await apiService.login(username, password);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String token = responseData['token'];
        await SharedPrefUtil.setStringInPref('token', token);

        SnackbarUtil.showSnackBar(Get.context!, "Login successful!");
        Get.offAll(() => const Home());
      } else {
        SnackbarUtil.showSnackBar(Get.context!, "Failed to login");
      }
    } catch (e) {
      SnackbarUtil.showSnackBar(Get.context!, 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
