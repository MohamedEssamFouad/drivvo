import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class CarModelHelper {
  final TextEditingController carModelController = TextEditingController();

  Future<void> loadCarModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    carModelController.text = prefs.getString('carModel') ?? '';
  }

  Future<void> saveCarModel(String userId, String carModel) async {
    final carModelData = {
      'userId': userId,
      'carModel': carModel,
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carModel', carModel);
  }
}
