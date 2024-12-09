import 'dart:ui';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLogged = false.obs;

  void login(String username, String password) {
    if (username == 'sharclen' && password == '12345') {
      isLogged.value = true;
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar(
        'Error',
        'Username atau Password salah',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 19, 11, 11),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  void logout() {
    isLogged.value = false;
    Get.offAllNamed('/login');
  }
}
