import 'package:drivvo/Views/Widgets/NavScreens/History.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Controller.dart';
import '../../consts/OnboardAssets.dart';
import '../Widgets/authScreen.dart';
class Content {
  final String title;
  final String description;

  Content(this.title, this.description);
}

class OnBoardSc extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  late PageController _controller;

  List<Content> contents = [
    Content("Now you can more quickly and easily track your vehicle",''),
    Content('For tracking your daily costs', 'Description 2'),
    Content('Your work expenses', 'Description 3'),
  ];

  @override
  Widget build(BuildContext context) {
    _controller = PageController(initialPage: 0);

    return Scaffold(
      backgroundColor: consts.myColorButtom,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Text(
                  'Drivvo',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: consts.myColorButtom,
                  ),
                ),
              ),
            ),


            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          fit: BoxFit.fitHeight,

                          OnboardAssets.images[index],

                        ),
                        SizedBox(height: 20,),
                        Text(
                          contents[index].title,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: consts.myColor,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                      (index) => buildDot(index, context),
                ),
              )),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  onPressed: () async {

                    if (controller.currentIndex.value == contents.length - 1) {
                     Get.to(()=>AuthScreen());
                     completeIntro();

                    }
                    _controller.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: consts.myColor,
                  ),
                  child: Obx(() => Text(
                    controller.currentIndex.value == contents.length - 1
                        ? "Get Started"
                        : "Next",
                    style: TextStyle(
                      color: consts.myColorButtom,
                      fontSize: 25,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: controller.currentIndex.value == index ? 100 : 15,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: controller.currentIndex.value == index ? consts.myColor: Colors.grey.shade600,
      ),
    );
  }
Future<void>completeIntro () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Get.off(()=>AuthScreen());
  }

}
