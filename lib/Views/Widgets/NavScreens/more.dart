import 'package:drivvo/consts/consts.dart';
import 'package:drivvo/consts/customGesture.dart';
import 'package:flutter/material.dart';

class more extends StatelessWidget {
  const more({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: consts.myColorButtom,
       iconTheme: IconThemeData(
         color: consts.myColor,
       ),
       title: Text(
         'More options',
         style: TextStyle(
           color: consts.myColor,
         ),

       ),
     ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CustomGesture(icon: Icons.topic, text: "Deivvo plans"),
              CustomGesture(icon: Icons.person, text: "My account"),
              CustomGesture(icon: Icons.sync, text: "Synchronize data"),
              CustomGesture(icon: Icons.storage, text: "Storage"),
              Divider(
                color: consts.myColorButtom,
                thickness: 0.2,
              ),
              CustomGesture(icon: Icons.car_repair, text: "Vehicles"),
              CustomGesture(icon: Icons.person , text: "Users"),
              CustomGesture(icon: Icons.verified_user, text: "Vehicle/user"),
              Divider(
                color: consts.myColorButtom,
                thickness: 0.2,
              ),
              CustomGesture(icon: Icons.power, text: "Fuel"),
              CustomGesture(icon: Icons.local_gas_station_rounded, text: "Gas stations"),
              CustomGesture(icon: Icons.place, text: "Places"),
              CustomGesture(icon: Icons.design_services_sharp, text: "Types of service"),
              CustomGesture(icon: Icons.credit_card_rounded, text: "Types of expense"),
              CustomGesture(icon: Icons.credit_card_sharp, text: "Types of income"),
              CustomGesture(icon: Icons.paypal, text: "Payment methods"),
              CustomGesture(icon: Icons.shopping_bag, text: "Resons"),
              CustomGesture(icon: Icons.text_format_sharp, text: "Forms"),
              Divider(
                color: consts.myColorButtom,
                thickness: 0.2,
              ),
              CustomGesture(icon: Icons.local_gas_station, text: "Where to refuel"),
              CustomGesture(icon: Icons.place, text: "My places"),
              CustomGesture(icon: Icons.calculate, text: "Flex calcualator"),
              CustomGesture(icon: Icons.star, text: "Acheivements"),
              Divider(
                color: consts.myColorButtom,
                thickness: 0.2,
              ),
              CustomGesture(icon: Icons.settings, text: "Settings"),
              CustomGesture(icon: Icons.translate, text: "translation"),
              Divider(
                color: consts.myColorButtom,
                thickness: 0.2,
              ),
              CustomGesture(icon: Icons.mail, text: "Contact"),
              CustomGesture(icon: Icons.info_outline, text: "about"),

            ],
          ),
        ),
      ),
    );
  }
}
