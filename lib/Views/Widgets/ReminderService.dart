import 'package:drivvo/Controller/mainController.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Controller.dart';
import '../../consts/customTextField.dart';

class ReminderSERVICE extends StatelessWidget {
  const ReminderSERVICE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController cont = TextEditingController();
    TextEditingController cont2 = TextEditingController();
    TextEditingController cont3 = TextEditingController();
    TextEditingController Next = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: consts.myColorButtom,
        iconTheme: IconThemeData(
          color: consts.myColor,
        ),
        title: Text(
          'Reminder',
          style: TextStyle(
            color: consts.myColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (Next.text.isNotEmpty) {
                try {
                  int targetOdometer = int.parse(Next.text);
                  final controller = Get.find<MainController>();
                  await controller.serviceHelper.predictAndSetReminder(targetOdometer);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Reminder set successfully!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid target odometer value ${e}")),

                  );
                  print(e);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a target odometer value")),
                );
              }
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomTextField(
              icon: Icons.miscellaneous_services,
              Text: "Type of service", // Changed Text to label for clarity
              controller: cont,
            ),
            SizedBox(height: 20),
            CustomTextField(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2500),
                );
                if (pickedDate != null) {
                  String formattedDate = "${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  cont2.text = formattedDate;
                }
              },
              icon: Icons.notification_add,
              Text: "Date",
              controller: cont2,
            ),
            SizedBox(height: 20),
            CustomTextField(
              icon: Icons.shutter_speed,
              Text: "Counter",
              controller: Next,
            ),
            SizedBox(height: 20),
            CustomTextField(
              icon: Icons.notes,
              Text: "Notes",
              controller: cont3,
            ),
          ],
        ),
      ),
    );
  }
}
