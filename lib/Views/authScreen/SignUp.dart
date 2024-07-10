import 'package:drivvo/Views/Widgets/chooseCar.dart';
import 'package:drivvo/Views/authScreen/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AuthController.dart';
import '../../consts/customButtom.dart';
import '../../consts/customField.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuthException

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final double coverH = 70;
    final double profileH = 90;
    final top = -(profileH / 2);

    return Scaffold(
      backgroundColor: consts.myColorButtom,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: top,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              'assests/images/unnamed-removebg-preview.png',
                              height: profileH,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          right: 60,
                          left: 70,
                          bottom: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Create a Drivvo account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          top: 110,
                          child: CustomField(
                            text: 'Email',
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          top: 200,
                          child: CustomField(
                            text: 'Password',
                            controller: passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Positioned(
                          top: 290,
                          right: 5,
                          left: 10,
                          child: CustomButtom(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                  await authController.signUpWithEmailPassword(context, emailController.text, passwordController.text);
                                }
                              },
                            color: consts.myColorButtom,
                            text: 'CREATE AN ACCOUNT',
                            colorT: Colors.white,
                            w: MediaQuery.of(context).size.width * 0.9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  Get.offAll(AuthScreen());
                },
                child: Text(
                  'Already have an account? Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
