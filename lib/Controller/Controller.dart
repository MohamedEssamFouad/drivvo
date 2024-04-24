import 'package:drivvo/model/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/initNotifications.dart';

class Controller extends GetxController {
  final DrivoDB db = DrivoDB();
  final TextEditingController carModelController = TextEditingController();

  RxInt currentIndex = 0.obs;
  RxInt CurrentIndexNav = 0.obs;
  RxBool hasDisplayedChooseCarPage = false.obs;
  var reminders=<Map<String,dynamic>>[].obs;
  RxBool isPasswordVisible = false.obs; // Add this line

  void togglePasswordVisibility() { // And this method
    isPasswordVisible.toggle(); // This toggles the observable value
  }
  void onReady() {
    super.onReady();
    togglePasswordVisibility();
    _checkDisplayedChooseCarPage();
    loadCarModel();
    fetchReminders();
  }
  @override
  void onInit() {

    super.onInit();
    togglePasswordVisibility();
    fetchReminders(); // Fetch reminders as soon as the controller is initialized
  }
  Future<void> fetchReminders() async {
    final fetchedReminders = await db.getReminders();
    if (fetchedReminders.isNotEmpty) {
      reminders.assignAll(fetchedReminders);
    } else {
      reminders.clear(); // Clear the list if no reminders are fetched
    }
  }
  void onChange(int index) {
    CurrentIndexNav.value = index;
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future <void> saveCarModel(String userId, String carModel) async {
    final carModelData = {
      'userId': userId,
      'carModel': carModel,
    };
    await db.insertUserCar(carModelData);
    await _markChooseCarPageDisplayed();
    saveCarModelPreference(carModel);
  }

  Future<void> saveCarModelPreference(String carModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carModel', carModel);
  }

  Future<void> loadCarModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    carModelController.text = prefs.getString('carModel') ?? '';
  }

  Future<void> _checkDisplayedChooseCarPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    hasDisplayedChooseCarPage.value =
        prefs.getBool('hasDisplayedChooseCarPage') ?? false;
  }

  Future<void> _markChooseCarPageDisplayed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasDisplayedChooseCarPage', true);
    hasDisplayedChooseCarPage.value = true;
  }

  Future<void> saveServiceDetails(String date, String time, String serviceType, String place, String note, int kilometers, String placeLocation, String placeName, String placeType) async {
    final Map<String, dynamic> serviceData = {
      'serviceDate': date,
      'serviceTime': time,
      'serviceType': serviceType,
      'Place': place,
    };

    final int serviceId = await db.insertCarService(serviceData);

    final Map<String, dynamic> servicePlaceData = {
      'servId': serviceId,
      'Location': placeLocation,
      'Name': placeName,
      'PlaceType': placeType,
    };
    await db.insertServicePlace(servicePlaceData);

    final Map<String, dynamic> kilometerData = {
      'carId': serviceId,
      'kilometers': kilometers,
      'note': note,
    };
    await db.insertServiceKilometer(kilometerData);

    await checkAndUpdateReminder(kilometers);
  }

  Future<void> checkAndUpdateReminder(int kilometers) async {
    final List<Map<String, dynamic>> reminders = await db.getReminders();
    Map<String, dynamic>? closestReminder;

    print("Checking reminders to update based on new service entry with $kilometers km...");

    for (var reminder in reminders) {
      int reminderCounter = int.parse(reminder['Counter']);
      print("Found reminder with target: $reminderCounter km");

      if (reminderCounter < kilometers) {
        print("Reminder target ($reminderCounter km) is less than current service kilometers ($kilometers km).");

        if (closestReminder == null || (reminderCounter > int.parse(closestReminder['Counter']))) {
          print("Updating closest reminder to current reminder with target: $reminderCounter km");
          closestReminder = reminder;
        }
      }
    }

    if (closestReminder != null) {
      print("Closest reminder to be updated: Target - ${closestReminder['Counter']} km, ID - ${closestReminder['id']}");

      await db.updateReminder(closestReminder['id'], {
        'Counter': kilometers.toString(),
      });

      print("Reminder successfully updated to $kilometers kilometers. ID: ${closestReminder['id']}");
    } else {
      print("No reminders found that require updating based on the new service entry.");
    }
  }

  Future<void> saveReminderDetails(String Typeserv, String serviceDate, String Counter,
      String Note) async {
    final Map<String, dynamic>Reminders = {
      'Typeserv': Typeserv,
      'serviceDate': serviceDate,
      'Counter': Counter,
      'Note': Note,
    };
    await db.insertReminder(Reminders);
    print('Saved service data: $Reminders');
  }

  Future<List<Map<String, dynamic>>> fetchServiceHistory() async {
    // Fetch car services and kilometers as before
    final List<Map<String, dynamic>> carServices = await db.getCarServices();
    final List<Map<String, dynamic>> serviceKilometers = await db
        .getServiceKilometers();
    List<Map<String, dynamic>> combinedServices = [];

    // Fetch reminders
    final List<Map<String, dynamic>> reminders = await db.getReminders();

    // Combine service and kilometer data
    for (var service in carServices) {
      Map<String, dynamic> combinedService = Map.from(service);

      // Find and add matching kilometers info
      var matchingKilometers = serviceKilometers.where((
          kilo) => kilo['carId'] == service['id']).toList();
      if (matchingKilometers.isNotEmpty) {
        combinedService.addAll(matchingKilometers.first);
      } else {
        combinedService['kilometers'] = 'Unknown';
        combinedService['note'] = 'No data';
      }

      // Fetch and add service place details
      final servicePlace = await db.getServicePlaceByServId(service['id']);
      if (servicePlace != null) {
        combinedService.addAll(servicePlace);
      }

      combinedServices.add(combinedService);
    }


    return combinedServices;
  }

  Future<void> predictAndSetReminder(int targetOdometer) async {
    final List<Map<String, dynamic>> services = await db.getCarServices();
    final List<Map<String, dynamic>> odometerReadings = await db.getServiceKilometers();

    if (services.isEmpty || odometerReadings.isEmpty) {
      print("Not enough data for prediction.");
      return;
    }

    List<double> daysSinceFirstService = [];
    List<double> odometerValues = [];
    DateTime firstServiceDate = DateFormat('yyyy-MM-dd').parse(services.first['serviceDate']);

    for (var reading in odometerReadings) {
      DateTime serviceDate = DateFormat('yyyy-MM-dd').parse(services.firstWhere((service) => service['id'] == reading['carId'])['serviceDate']);
      int days = serviceDate.difference(firstServiceDate).inDays;
      daysSinceFirstService.add(days.toDouble());
      odometerValues.add(double.parse(reading['kilometers'].toString()));
    }

    double slope = calculateSlope(daysSinceFirstService, odometerValues);

    if (slope <= 0) {
      print("Invalid slope calculated. Check your data.");
      return;
    }

    double lastKnownOdometer = odometerValues.last;
    DateTime lastServiceDate = DateFormat('yyyy-MM-dd').parse(services.last['serviceDate']); // Use the last service date
    double daysToTarget = (targetOdometer - lastKnownOdometer) / slope;
    DateTime targetDate = lastServiceDate.add(Duration(days: daysToTarget.round()));

    await saveReminderDetails(
        "Service Reminder",
        DateFormat('yyyy-MM-dd').format(targetDate),
        targetOdometer.toString(),
        "Reminder: Service due for odometer reading $targetOdometer"
    );

    print('Reminder set for $targetOdometer km on ${DateFormat('yyyy-MM-dd').format(targetDate)}');
    NotificationService.showScheduledNotification(
      id: 1, // Unique ID for this notification
      title: 'Service Reminder',
      body: 'Your car service is due for odometer reading $targetOdometer',
      scheduledDate: targetDate,
    );
    print('Notification scheduled for: $targetDate ');
  }

  double calculateSlope(List<double> x, List<double> y) {
    int n = x.length;
    double meanX = x.reduce((a, b) => a + b) / n;
    double meanY = y.reduce((a, b) => a + b) / n;

    double num = 0.0;
    double den = 0.0;
    for (int i = 0; i < n; i++) {
      num += (x[i] - meanX) * (y[i] - meanY);
      den += (x[i] - meanX) * (x[i] - meanX);
    }

    return num / den;
  }


  Future<void> saveReminderDetailss(String typeServ, String serviceDate, String counter, String note) async {
    print('Reminder saved: $typeServ, $serviceDate, $counter, $note');
  }


}