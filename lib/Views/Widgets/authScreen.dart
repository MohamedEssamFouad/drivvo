import 'package:drivvo/Views/Widgets/NavBar.dart';
import 'package:drivvo/Views/Widgets/NavScreens/History.dart';
import 'package:drivvo/Views/Widgets/SignUp.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Controller/Controller.dart';
import '../../consts/customButtom.dart';
import '../../consts/customField.dart';
import 'chooseCar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    final Controller controller = Get.find<Controller>();

    Future<void> signInWithGoogle(BuildContext context) async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          if (userCredential.user != null) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChooseCar()));
          }
        }
      } catch (error) {
        print("Sign in with Google failed: $error");
      }
    }

    final double coverH = 70;
    final double profileH = 90;
    final top = -(profileH / 2);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: consts.myColorButtom,
      body: Column(
        children: [
          Center(
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.50,
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
                                  'Log in using',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 80,
                            right: 20,
                            child: CustomButtom(
                              onTap: () async {
                                await signInWithGoogle(context);
                              },
                              text: 'Google',
                              w: 140,
                              imageurl: 'https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png',
                            ),
                          ),
                          Positioned(
                            top: 80,
                            left: 20,
                            child: CustomButtom(
                              text: 'Facebook',
                              w: 140,
                              imageurl: 'https://e7.pngegg.com/pngimages/226/903/png-clipart-logo-social-media-facebook-brand-social-media-text-logo.png',
                            ),
                          ),
                          Positioned(
                            top: 135,
                            right: 60,
                            left: 165,
                            bottom: 10,
                            child: Text('OR', style: TextStyle(fontSize: 20)),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            top: 170,
                            child: CustomField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Email';
                                }
                                return null;
                              },

                              controller: controller1,
                              text: 'Email',
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            top: 250,
                            child: CustomField(
                              controller: controller2,
                              text: 'Password',
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
                            top: 305,
                            left: 5,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: consts.myColorButtom,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 340,
                            right: 5,
                            left: 10,
                            child: CustomButtom(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (!controller.hasDisplayedChooseCarPage.value) {
                                    Get.to(() => ChooseCar());
                                  } else {
                                    Get.to(() => NavBar());
                                  }
                                }
                              },
                              color: consts.myColorButtom,
                              text: 'LOG IN',
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


            ),
          TextButton(
            onPressed: () {
              Get.to(() => SignUp());
            },
            child: Text(
              'CREATE AN ACCOUNT',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),

    );
  }
}
