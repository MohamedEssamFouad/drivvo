import 'package:drivvo/Controller/mainController.dart';
import 'package:drivvo/Views/Widgets/NavBar.dart';
import 'package:drivvo/Views/Widgets/NavScreens/History.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:drivvo/consts/customButtom.dart';
import 'package:drivvo/consts/customField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Controller.dart';

class ChooseCar extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    return Scaffold(
    resizeToAvoidBottomInset: false, // Prevents resizing due to keyboard
    appBar: AppBar(
    centerTitle: true,
    title: Text(
    'Vehicle registration',
    style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: consts.myColorButtom,
    ),
      body: Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children:[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(

                  color: consts.myColorButtom,
                ),

              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.2,
                decoration: BoxDecoration(
                  color: consts.myColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                  ),
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(Icons.directions_car,color: consts.myColorButtom,),
                            ),
                            Flexible(
                              child: CustomField(

                                text: "Car model",
                                controller: controller.carModelHelper.carModelController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter car model';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: CustomButtom(

                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await controller.carModelHelper.saveCarModel("userId1", controller.carModelHelper.carModelController.text);
                                Get.to(() => const NavBar());
                              }
                            },
                            w: MediaQuery.of(context).size.width * 0.85,
                            text: "Register",
                            color: consts.myColorButtom,
                            colorT: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.3,
                  decoration: BoxDecoration(
                    color: consts.myColor,

                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.3,
                  decoration: BoxDecoration(
                    color: consts.myColorButtom,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
          );
  }
}
