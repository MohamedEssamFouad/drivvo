import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Views/authScreen/AuthScreen.dart';
class OnboardController{


  Future<void>completeIntro () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Get.off(()=>AuthScreen());
  }
}
