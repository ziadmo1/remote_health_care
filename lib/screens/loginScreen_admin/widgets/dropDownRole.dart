import 'package:flutter/material.dart';

class DropDownRoleBtn extends StatefulWidget {
  String item;
  DropDownRoleBtn(this.item);

  @override
  State<DropDownRoleBtn> createState() => _DropDownRoleBtnState();
}

class _DropDownRoleBtnState extends State<DropDownRoleBtn> {
  List<String> roles = ['Doctor','Care Giver'];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Role',
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
            items: roles.map((item) {
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
