import 'package:drivvo/consts/consts.dart';
import 'package:drivvo/consts/customTextField.dart';
import 'package:flutter/material.dart';

class route extends StatelessWidget {
  route({super.key});



  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();

    return Scaffold(
appBar: AppBar(
  
  backgroundColor: consts.myColorButtom,
  iconTheme: IconThemeData(
    color: consts.myColor,

  ),
  title: Text(
    'Route',
    style: TextStyle(
      color: consts.myColor,
    ),
  ),
  actions: [
    IconButton(onPressed: (){}, icon: Icon(Icons.done)),
  ],
),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CustomTextField(icon: Icons.trip_origin, controller: controller,Text: "Origin",),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.5,
                  child: CustomTextField(
                    controller: controller,
                    Text: "Start date",
                    icon: Icons.date_range,

                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.5,
                  child: CustomTextField(
                    controller: controller,
                    Text: "Time",
                    icon: Icons.watch_later,

                  ),
                ),
              ],
            ),
              CustomTextField(icon: Icons.gps_not_fixed, controller: controller,Text: "Destination",),

              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.5,
                    child: CustomTextField(
                      controller: controller,
                      Text: "End date",
                      icon: Icons.date_range,

                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.5,
                    child: CustomTextField(
                      controller: controller,
                      Text: "Time",
                      icon: Icons.watch_later,

                    ),
                  ),
                ],
              ),
              CustomTextField(icon: Icons.gas_meter, controller: controller,Text: "Final odometer",),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.5,
                    child: CustomTextField(
                      controller: controller,
                      Text: "Value km *optional",
                      icon: Icons.price_change,

                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.5,
                    child: CustomTextField(
                      controller: controller,
                      Text: "Total",
                      icon: Icons.monetization_on_sharp,

                    ),
                  ),
                ],
              ),
              CustomTextField(icon: Icons.padding, controller: controller,Text: "Driver",),
              CustomTextField(icon: Icons.shopping_bag_outlined, controller: controller,Text: "Reason",),
              CustomTextField(icon: Icons.notes, controller: controller,Text: "Notes",),


            ],
          ),
        ),
      ),
    );
  }
}
