import 'package:drivvo/Views/Widgets/NavBar.dart';
import 'package:drivvo/Views/Widgets/NavScreens/History.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controller/Controller.dart';
import '../../../consts/customTextField.dart';

class Servicee extends StatelessWidget {
  const Servicee({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();
    TextEditingController controller2=TextEditingController();
    TextEditingController controller3=TextEditingController();
    TextEditingController controller4=TextEditingController();
    TextEditingController controller5=TextEditingController();
    TextEditingController controller6=TextEditingController();
    TextEditingController PlaceName=TextEditingController();
    TextEditingController PlaceLocation=TextEditingController();
    TextEditingController PlaceType=TextEditingController();



    final _formKey = GlobalKey<FormState>();  // Add this line



    return Scaffold(
      appBar: AppBar(
        backgroundColor: consts.myColorButtom,
        iconTheme: IconThemeData(
          color: consts.myColor,
        ),
        title: Text(
          'Service',
          style: TextStyle(
            color: consts.myColor
          ),

        ),
actions: [
  IconButton(onPressed: (){
    if (_formKey.currentState!.validate()) {
      // Parse the odometer string to an integer safely
      int odometerValue = int.tryParse(controller3.text) ?? 0; // Provides a default value of 0 if parsing fails

      Get.find<Controller>().saveServiceDetails(
        controller.text, // Date
        controller2.text, // Time
        controller4.text, // Service Type
        controller5.text, // Place
        controller6.text, // Notes
        odometerValue, // Correctly parsed as int
        PlaceLocation.text,
        PlaceName.text,
        PlaceType.text,
      );
      Get.to(() => NavBar());
    }
  }, icon: Icon(Icons.done)),

],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key:_formKey ,
            child: Column(
              children: [
                Row(
                  children:[
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width*0.5,

                      child: CustomTextField(
                        onTap: () async {
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Time';  // Your validation message
                            }
                            return null;  // Return null if the input is valid
                          };
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), // Ensure this is set
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2500),
                          );
                          if (pickedDate != null) {
                            String formattedDate = "${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";
                            controller.text = formattedDate;
                          }
                        },

                        icon: Icons.date_range,
                        controller: controller,
                        Text: "Date",
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width*0.5,
              child: CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Time';  // Your validation message
                  }
                  return null;  // Return null if the input is valid
                },
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    final String formattedTime = pickedTime.format(context);
                    controller2.text = formattedTime; // Update the text of the TextEditingController with formatted time
                  }
                },
                icon: Icons.watch_later_outlined,
                controller: controller2,
                Text: "Time",
              ),
                    ),
                  ],
                ),
                CustomTextField(

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Odometer';  // Your validation message
                    }
                    return null;  // Return null if the input is valid
                  },
                  icon: Icons.speed, controller: controller3,Text: "Odometer",keyboardType:TextInputType. number,),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Service';  // Your validation message
                    }
                    return null;  // Return null if the input is valid
                  },
                  icon: Icons.miscellaneous_services, controller: controller4,Text: "Type of service",),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Place';  // Your validation message
                    }
                    return null;  // Return null if the input is valid
                  },icon: Icons.place, controller: controller5,Text: "Place",),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Note';  // Your validation message
                    }
                    return null;  // Return null if the input is valid
                  },icon: Icons.note_add, controller: controller6,Text: "Notes",),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Place Name';  // Your validation message
                    }
                    return null;  // Return null if the input is valid
                  },icon: Icons.drive_file_rename_outline, controller: PlaceName,Text: "Place Name",),
               // CustomTextField(icon: Icons.find_replace, controller: PlaceLocation,Text: "Place Location",),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Place Type';  // Your validation message
                    }
                    return null;  // Return null if the input is valid
                  },icon: Icons.local_gas_station_sharp, controller: PlaceType,Text: "Place Type",),





              ],
            ),
          ),
        ),
      ),
    );
  }
}
