
import 'package:drivvo/Controller/Service_Operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import'../Controller/Controller.dart';

import '../Controller/Service_Operations.dart';
import '../Controller/Service_Operations.dart';
import '../Controller/mainController.dart';
import 'consts.dart';
final MainController controller = Get.put(MainController());

Container buildDot(int index, BuildContext context) {
  return Container(
    height: 10,
    width: controller.serviceHelper.currentIndex.value == index ? 100 : 15,
    margin: EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: controller.serviceHelper.currentIndex.value == index ? consts.myColor: Colors.grey.shade600,
    ),
  );
}