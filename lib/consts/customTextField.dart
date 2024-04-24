import 'package:drivvo/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.icon, required this.controller, this.Text, this.onTap, this.keyboardType, this.validator});
  final IconData icon;
  final TextEditingController controller;
  final String? Text;
  final void Function()? onTap;
  final keyboardType;
  final String? Function(String?)? validator;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon,color: consts.myColorButtom,),
         // SizedBox(width: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                keyboardType: keyboardType,
                onTap: onTap,
                validator: validator,

                controller: controller,
                decoration: InputDecoration(
                  hintText: Text,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: consts.myColorButtom),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 35),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
