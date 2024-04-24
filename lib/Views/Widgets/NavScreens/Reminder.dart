import 'dart:developer';

import 'package:drivvo/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Controller.dart';

class Reminder extends StatelessWidget {
  const Reminder({super.key});

  @override
  Widget build(BuildContext context) {
    // Find your Controller
    final Controller controller = Get.find<Controller>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchReminders();
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: consts.myColor),
        backgroundColor: consts.myColorButtom,
        title: Text('Reminders', style: TextStyle(color: consts.myColor)),
      ),
      body: Obx(() {
        if (controller.reminders.isEmpty) {
          // Display image if no reminders
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn-icons-png.flaticon.com/256/8003/8003416.png',
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 20),
                Text(
                  'No Reminders Found',
                  style: TextStyle(
                    color: consts.myColorButtom,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else {
          // Display list of reminders
          return ListView.builder(
            itemCount: controller.reminders.length,
            itemBuilder: (context, index) {
              final reminder = controller.reminders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: GestureDetector(
                  onTap: (){
                    Get.to(Service());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: consts.myColorButtom,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.miscellaneous_services,
                        color: consts.myColor,
                      ),
                      title: Text(reminder['Typeserv'] ?? 'Unknown Service',style: TextStyle(
                        color: consts.myColor,
                      ),),
                      subtitle: Text(reminder['serviceDate'] ?? 'No Date',style: TextStyle(
                        color: consts.myColor,
                      ),),
                      trailing: IconButton(
                          onPressed: (){},
                        icon: Icon(Icons.delete,color: consts.myColor,),
                      ),

                      // Add more fields as necessary
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
