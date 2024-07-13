import 'package:get/get.dart';

class PasswordVisibilityHelper {
  RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }
}
