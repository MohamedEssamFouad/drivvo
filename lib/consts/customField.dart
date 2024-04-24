import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Controller.dart'; // Adjust the import based on your project structure

class CustomField extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;

  CustomField({
    Key? key,
    required this.text,
    this.controller,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find<Controller>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            obscureText: isPassword
                ? !controller.isPasswordVisible.value
                : false,
            controller: this.controller,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              suffixIcon: isPassword ? Obx(() =>
                  IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  )) : null,
            ),
          ),
        ),
      ),
    );
  }
}