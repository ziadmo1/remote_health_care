import 'package:flutter/material.dart';

class DropDownBtn extends StatefulWidget {
  String item;
  DropDownBtn(this.item);

  @override
  State<DropDownBtn> createState() => _DropDownBtnState();
}

class _DropDownBtnState extends State<DropDownBtn> {
  List<String> genders = ['Male','Female'];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Gender',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 28
        ),
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: DropdownButton<String>(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            isExpanded: true,
            underline: Container(color: Colors.white,height: 1,),
            iconEnabledColor: Colors.black,
            items: genders.map((item) {
                  return DropdownMenuItem<String>(child: Text(item,
                  ), value: item);})
                .toList(),
            onChanged: (text) {
              setState(() {
                widget.item = text!;
              });
            },
            value: widget.item,
          ),
        ),
      ],
    );
  }
}
