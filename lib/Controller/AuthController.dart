import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Views/Widgets/chooseCar.dart';
import '../consts/consts.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Future<void> signInWithEmailPassword(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChooseCar()));
      }
    } catch (error) {
      print("Sign in with Email and Password failed: $error");
    }
  }

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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChooseCar()));
        }
      }
    } catch (error) {
      print("Sign in with Google failed: $error");
    }
  }

  Future<void> signUpWithEmailPassword(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChooseCar()));
      }
    } catch (error) {
      if (error is FirebaseAuthException && error.code == 'email-already-in-use') {
        // Show alert dialog for email already in use
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Sign Up Failed",
          content: Text(
            "The email address is already in use by another account.",
            style: TextStyle(color: consts.myColorButtom),
          ),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text(
              'OK',
              style: TextStyle(color: consts.myColorButtom),
            ),
          ),
        );
      } else {
        // Handle other exceptions
        print("Sign up with Email and Password failed: $error");
      }
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      throw error;
    }
  }
}
