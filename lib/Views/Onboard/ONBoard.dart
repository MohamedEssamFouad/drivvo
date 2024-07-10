import 'package:drivvo/Controller/mainController.dart';
import 'package:drivvo/Controller/onBoardController.dart';
import 'package:drivvo/Views/Onboard/contents.dart';
import 'package:drivvo/Views/Widgets/NavScreens/History.dart';
import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/Controller.dart';
import '../../consts/OnboardAssets.dart';
import '../../consts/customBuildDot.dart';
import '../authScreen/AuthScreen.dart';

class OnBoardSc extends StatelessWidget {
  final MainController controller = Get.put(MainController());
  late PageController _controller;
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
                itemCount: Content.contents.length,
                onPageChanged: controller.serviceHelper.onPageChanged,
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
                          Content.contents[index].title,
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
                  Content.contents.length,
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
                    if (controller.serviceHelper.currentIndex.value == Content.contents.length - 1) {
                     Get.to(()=>AuthScreen());
                     OnboardController().completeIntro();
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
                    controller.serviceHelper.currentIndex.value == Content.contents.length - 1
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
}
