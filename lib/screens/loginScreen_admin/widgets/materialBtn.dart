import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/signUp_admin.dart';

class MaterialBtn extends StatelessWidget {
  String title1;
  String title2;
  GestureTapCallback function;
  MaterialBtn(this.title1,this.title2,this.function);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title1,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white54
        ),
        ),
        InkWell(
            onTap: function,
            child:
        Text(title2,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline
        ),))
      ],
    );
  }
}
