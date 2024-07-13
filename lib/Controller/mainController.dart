import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/db.dart';
import '../model/initNotifications.dart';
import 'CarModelHelper.dart';
import 'PasswordVisibilityHelper.dart';
import 'Service_Operations.dart';
import 'carHandling_controller.dart';

class MainController extends GetxController {
  final PasswordVisibilityHelper passwordHelper = PasswordVisibilityHelper();
  final CarModelHelper carModelHelper = CarModelHelper();
  final ChooseCarPageHelper chooseCarPageHelper = ChooseCarPageHelper();
  final ServiceOperationsHelper serviceHelper = ServiceOperationsHelper();

  @override
  void onReady() {
    super.onReady();
    passwordHelper.togglePasswordVisibility();
    chooseCarPageHelper.checkAndMarkChooseCarPageDisplayed();
    carModelHelper.loadCarModel();
    serviceHelper.fetchReminders();
  }

  @override
  void onInit() {
    super.onInit();
    passwordHelper.togglePasswordVisibility();
    serviceHelper.fetchReminders(); // Fetch reminders as soon as the controller is initialized
  }
}
