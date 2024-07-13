import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseCarPageHelper {
  RxBool hasDisplayedChooseCarPage = false.obs;

  Future<void> checkAndMarkChooseCarPageDisplayed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    hasDisplayedChooseCarPage.value =
        prefs.getBool('hasDisplayedChooseCarPage') ?? false;
  }



}
