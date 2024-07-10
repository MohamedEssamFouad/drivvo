
import 'package:drivvo/Controller/mainController.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Controller.dart';
import 'NavScreens/History.dart';
import 'NavScreens/Reminder.dart';
import 'NavScreens/Servicee.dart';
import 'NavScreens/more.dart';
import 'NavScreens/route.dart';
import 'ReminderService.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();

    return Scaffold(
        body: Obx(
          ()=>
          IndexedStack(
            index:controller.serviceHelper.CurrentIndexNav.value ,
            children: [
              history(),
              Reminder(),
              route(),
              more(),


            ],

          ),
        ),
      bottomNavigationBar: Obx(
        ()=> BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            controller.serviceHelper.onChange(value); // Correctly change the index
          },
          currentIndex: controller.serviceHelper.CurrentIndexNav.value, // Set the currentIndex for the BottomNavigationBar
          selectedItemColor: consts.myColorButtom,
          unselectedItemColor: Colors.black,
          items: [
            itemBar(Icons.history, 'History', controller.serviceHelper.CurrentIndexNav.value == 0),
            itemBar(Icons.notifications, 'Reminders', controller.serviceHelper.CurrentIndexNav.value == 1),
            itemBar(Icons.map, 'Route', controller.serviceHelper.CurrentIndexNav.value == 2),
            itemBar(Icons.more_horiz, 'More', controller.serviceHelper.CurrentIndexNav.value == 3),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          _showPopupMenu(context);
        },
        backgroundColor: consts.myColorButtom,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }
}
BottomNavigationBarItem itemBar(IconData icon, String label, bool isSelected) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      size: 25,
      color: isSelected ? consts.myColorButtom : Colors.grey,
    ),
    label: label,
  );
}
void _showPopupMenu(BuildContext context) async {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromLTWH(
        overlay.size.width / 2, // X position
        overlay.size.height - 80, // Y position (adjust based on FAB position)
        1,
        1,
      ),
      Offset.zero & overlay.size, // Proper size and position
    ),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>ReminderSERVICE());
            },
            child: Row(
              children: [
                Icon(
                  Icons.alarm,
                ),
                SizedBox(width: 3,),
                Text('Reminder',style: TextStyle(
  color: consts.myColorButtom,
  ),),
              ],
            )),
        value: 'Option1',
      ),
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>Reminder());
            },
            child: Row(
              children: [
                Icon(
                  Icons.checklist,
                ),
                SizedBox(width: 3,),
                Text('Checklist',style: TextStyle(
  color: consts.myColorButtom,
  ),),
              ],
            )),
        value: 'Option1',
      ),
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>Reminder());
            },
            child: Row(
              children: [
                Icon(
                  Icons.credit_card_outlined,
                ),
                SizedBox(width: 3,),
                Text('Income',style: TextStyle(
  color: consts.myColorButtom,
  ),),
              ],
            )),
        value: 'Option1',
      ),
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>Reminder());
            },
            child: Row(
              children: [
                Icon(
                  Icons.route,
                ),
                SizedBox(width: 3,),
                Text('Route',style: TextStyle(
                  color: consts.myColorButtom,
                ),),
              ],
            )),
        value: 'Option1',
      ),
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>Servicee());
            },
            child: Row(
              children: [
                Icon(
                  Icons.design_services_sharp,
                ),
                SizedBox(width: 3,),
                Text('Service',style: TextStyle(
  color: consts.myColorButtom,
  ),),
              ],
            )),
        value: 'Option1',
      ),
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>Reminder());
            },
            child: Row(
              children: [
                Icon(
                  Icons.credit_card_outlined,
                ),
                SizedBox(width: 3,),
                Text('Expense',style: TextStyle(
  color: consts.myColorButtom,
  ),),
              ],
            )),
        value: 'Option1',
      ),
      PopupMenuItem(
        child: InkWell(
            onTap: (){
              Get.to(()=>Reminder());
            },
            child: Row(
              children: [
                Icon(
                  Icons.local_gas_station_rounded,
                ),
                SizedBox(width: 3,),
                Text('Refueling',style: TextStyle(
  color: consts.myColorButtom,
  ),),
              ],
            )),
        value: 'Option1',
      ),
    ],
  ).then((value) {
    // Handle the action based on the selected value
    if (value != null) {
      print('You selected: $value');
      // Here, you can add your actions based on the selected item.
      // For example, navigate to different screens or perform other actions.
    }
  });
}

