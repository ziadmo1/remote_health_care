import 'package:flutter/material.dart';
import 'package:remote_healthcare/themes/myTheme.dart';

class TextFiield extends StatelessWidget {
  String hint;
  Widget? suffIcon;
  IconData? prefIcon;
  FormFieldValidator<String> validate;
  bool isVisible;
  TextEditingController? controller;
  TextInputType? keyboard;
  TextFiield({this.keyboard,required this.hint,this.suffIcon, this.prefIcon,required this.validate,this.isVisible = false, this.controller});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      obscureText: isVisible,
      validator: validate,
      enabled: true,
      cursorColor: Colors.black,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black45
        ),
        suffixIcon: suffIcon,
        prefixIcon: Icon(prefIcon,color: Colors.black45,),
        filled: true,
        fillColor: MyTheme.lightOrange,
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 1,
                color: Colors.white
            )
        ),
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 1,
                color: Colors.white
            )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white
          )
        )
      ),
    );
  }
}
