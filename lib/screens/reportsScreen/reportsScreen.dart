import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../loginScreen_admin/models/AuthAdminRes.dart';

class ReportsScreen extends StatefulWidget {
static const String routeName = 'report';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    var reports = ModalRoute.of(context)?.settings.arguments as List<Reports>;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.all(size.width * 0.03),
            height: size.height * 0.17,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${DateFormat.yMMMd().format(DateTime.parse(reports[index].createdAt??''))}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 10,),
                Text('Time: ${DateFormat.jm().format(DateTime.parse(reports[index].createdAt??'').add(Duration(hours: 2)))}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('spo2'.toUpperCase(),  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
                ),
                        SizedBox(height: 5,),
                        Text(reports[index].spo2.toString(),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: [
                        Text('heart rate'.toUpperCase(),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 5,),
                        Text(reports[index].heartRate.toString(),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: [
                        Text('temperature'.toUpperCase(),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 5,),
                        Text(reports[index].temperature.toString(),style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
        itemCount: reports.length,
      ),
    );
  }
}
