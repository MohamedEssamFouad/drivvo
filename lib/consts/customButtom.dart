import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key, required this.w, this.imageurl, required this.text,  this.color, this.colorT,this.onTap});
  final double w;
  final String? imageurl; // Making this nullable in case you want to handle buttons without images.
  final String text;
  final Color? color;
  final Color? colorT;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        alignment: Alignment.center,
        height: 50,
        width: w,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color:consts.myColorButtom,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // This makes the Row only as wide as its children
          children: [
            if (imageurl != null) ...[ // Only add the image if the URL is not null
              Container(
                margin: EdgeInsets.only(right: 8.0), // Add some space between the image and the text
                width: 24, // Set your desired width for the image
                height: 24, // Set your desired height for the image
                child: Image.network(imageurl!, fit: BoxFit.cover), // Use your image URL here
              ),
            ],
            Text(text,style: TextStyle(
              color: colorT,
            ),),
          ],
        ),
      ),
    );
  }
}
