import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../consts/customButtom.dart';
import '../../consts/customField.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final double coverH = 70;
    final double profileH = 90;
    final top = -(profileH / 2);

    return Scaffold(
      backgroundColor: consts.myColorButtom,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none, // This is important to ensure the image can go outside of the container
                      children: [
                        // Add other children of the stack here if needed
                        Positioned(
                          top: top, // Position the image so half is above the container
                          left: 0,
        
                          right: 0,
                          child: Center( // This will center the image horizontally within the Stack
                            child: Image.asset(
                              'assests/images/unnamed-removebg-preview.png',
                              height: profileH, // Set this to control the size of your image
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          right: 60,
                          left: 70,
                          bottom: 10,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Create a Drivvo account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ]
        
                          ),
                        ),
        
                        Positioned(
                          top: 80,
                          right: 20,
                          child: CustomButtom(
                            text: 'Google',
                            w: MediaQuery.sizeOf(context).width*0.8,
                            imageurl: 'https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png',
        
                          ),
                        ),
                        Positioned(
                          top: 150,
                          right: 20,
                          child: CustomButtom(
                            text: 'Google',
                            w: MediaQuery.sizeOf(context).width*0.8,
                            imageurl: 'https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png',

                          ),
                        ),
                        Positioned(
                            top: 210,
                            right: 60,
                            left: 165,
                            bottom: 10,
        
                            child: Text('OR',style: TextStyle(fontSize: 20),)),
                        Positioned(
                            right: 0,
                            left:0 ,
                            top: 250,
                            child: CustomField(
                              text: 'Email',
                            )),

                        Positioned(
                            right: 0,
                            left:0 ,
                            top: 320,
                            child: CustomField(
                              text: 'Email',
                            )),
                        Positioned(
                            right: 0,
                            left:0 ,
                            top: 390,
                            child: CustomField(
                              text: 'Email',
                            )),
                        Positioned(
                            right: 0,
                            left:0 ,
                            top: 460,
                            child: CustomField(
                              text: 'Email',
                            )),
                        Positioned(
                            right: 0,
                            left:0 ,
                            top: 530,
                            child: CustomField(
                              text: 'Email',
                            )),
                        Positioned(
                          top: 600,
                          right: 5,
                          left: 10,
                          child: CustomButtom(
                            color: consts.myColorButtom,
                            text: 'CREATE AN ACCOUNT',
                            colorT: Colors.white,
                            w: MediaQuery.sizeOf(context).width*0.9,


                          ),
                        ),
                        Positioned(
                          top: 670,
                          right: 5,
                          left: 10,
                          child: TextButton(
                            onPressed: (){},
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                color: consts.myColorButtom,
                              ),
                            ),
                          )
                        ),
                      ],
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
