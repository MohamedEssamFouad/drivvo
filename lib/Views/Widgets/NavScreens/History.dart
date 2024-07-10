import 'package:drivvo/Controller/Controller.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../Controller/mainController.dart';

class history extends StatelessWidget {
  const history({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: consts.myColorButtom,
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      controller.carModelHelper.carModelController.text,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: consts.myColorButtom,
                      ),
                    ),
                  ),

                  const Icon(Icons.arrow_drop_down_sharp),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: controller.serviceHelper.fetchServiceHistory(), // This should fetch combined service details
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) { // Check that there is data
                    final services = snapshot.data!;
                    return ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width*0.9,
                            height: MediaQuery.sizeOf(context).height*0.18,
                            child: Card(
                              elevation: 40,
                              shadowColor: consts.myColorButtom,
                              color: consts.myColorButtom,

                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.directions_car,color: consts.myColor,),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text( 'Service Type : ${service['serviceType'] ?? 'No Type'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),
                                            SizedBox(height: 5),
                                            Text('Odometer: ${service['kilometers']} Km',style: TextStyle(
                                              color: consts.myColor,
                                            ),),
                                            SizedBox(height: 5),
                                            Text('Date: ${service['serviceDate'] ?? 'No Date'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),


                                            SizedBox(height: 5),
                                            Text('PlaceName: ${service['Name'] ?? 'No Date'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),

                                            SizedBox(height: 5),
                                          ],
                                        ),
                                       Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Time: ${service['serviceTime'] ?? 'No Time'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),
                                            SizedBox(height: 5),
                                            Text('Place: ${service['Place'] ?? 'No Place'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),
                                            SizedBox(height: 5),
                                            Text('Notes: ${service['note'] ?? 'No Notes'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),
                                            SizedBox(height: 5),
                                            Text('PlaceType: ${service['PlaceType'] ?? 'No Notes'}',style: TextStyle(
                                              color: consts.myColor,
                                            ),),
                                            SizedBox(height: 5),
                                          ],
                                        ),



                                      ],
                                    ),
                                  ),

                                  // Additional details shown on tap


                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No service history available'),
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}