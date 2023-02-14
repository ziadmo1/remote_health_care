import 'package:flutter/material.dart';
import 'package:remote_healthcare/themes/myTheme.dart';


class TextButtoon extends StatelessWidget {
  String titleBtn;
  GestureTapCallback onTap;
  TextButtoon(this.titleBtn,this.onTap);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 5,
        shadowColor: Colors.grey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          height: size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Text(
                titleBtn,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: MyTheme.lightOrange,
              )
            ],
          ),
        ),
      ),
    );
  }
}
