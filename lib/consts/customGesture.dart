import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';

class CustomGesture extends StatelessWidget {
  const CustomGesture({super.key, required this.icon, required this.text});
final IconData icon;
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      child: GestureDetector(
        child: Row(
          children: [
            Icon(icon,color: consts.myColorButtom,),
            SizedBox(width: 10,),
            Text(text,style: TextStyle(
              color: consts.myColorButtom,
              fontSize: 20,
            ),),
          ],

        ),
      ),
    );
  }
}
