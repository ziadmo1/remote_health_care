import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../loginScreen_admin/models/AuthAdminRes.dart';

class ReportsScreen extends StatefulWidget {
static const String routeName = 'report';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  dynamic values;
  int spo2 = 0;
  int heartRate = 0;
  String temp = '';
  int index = 0;
  String? phone;
  @override
  void initState() {
    super.initState();
    initPush();
  }
  @override
  void dispose() {
    pusher.disconnect();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var patients = ModalRoute.of(context)?.settings.arguments as Patients;
    var reports = patients.reports?.reversed.toList();
      if(index == 0){
       phone = patients.phoneNumber;
        index++;
        setState(() {

        });
      }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              elevation: 8,
              color: Colors.white,
              margin: EdgeInsets.all(size.width * 0.05),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.all(size.width * 0.02),
                height: size.height * 0.3,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        values == null || temp == '-999'&&spo2 == -999&& heartRate == -999 ||  temp == '' && spo2 == 0 && heartRate == 0
                            ? Lottie.asset('assets/activeRed.json',
                            width: size.width * 0.06,
                            fit: BoxFit.fill)
                            : Lottie.asset('assets/activeGreen.json',
                            width: size.width * 0.06,
                            fit: BoxFit.fill),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          patients.username ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Column(
                          children: [
                            Lottie.asset('assets/heartRate.json',
                                width: size.width * 0.25,
                                fit: BoxFit.fill),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            values == null || heartRate == -999 || heartRate == 0
                                ? Lottie.asset('assets/loading.json',
                                width: size.width * 0.25,
                                fit: BoxFit.fill)
                                : Text(
                              heartRate.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Lottie.asset('assets/spo2.json',
                                width: size.width * 0.3,
                                height: size.height * 0.115,
                                fit: BoxFit.fill),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            values == null || spo2 == -999 || spo2 == 0
                                ? Lottie.asset('assets/loading.json',
                                width: size.width * 0.25,
                                fit: BoxFit.fill)
                                : Text(
                              spo2.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Lottie.asset('assets/temp.json',
                                width: size.width * 0.25,
                                fit: BoxFit.fill),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            values == null || temp == '-999' || temp == ''
                                ? Lottie.asset('assets/loading.json',
                                width: size.width * 0.25,
                                fit: BoxFit.fill)
                                : Text(
                              temp,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                      Text('Date: ${DateFormat.yMMMd().format(DateTime.parse(reports![index].createdAt??''))}',
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
              itemCount: reports?.length,
            ),
          ],
        ),
      ),
    );
  }
  initPush() async {
    await pusher.init(
        apiKey: '17e704d4e34a2978834b',
        cluster: 'eu',
        useTLS: true,
        onEvent: onEvent);
    await pusher.connect();
    await pusher.subscribe(channelName: 'user-$phone');
  }

  onEvent(PusherEvent event) async {
    values = jsonDecode(event.data);
    spo2 = values['spo2'] ?? spo2;
    heartRate = values['heartRate'] ?? heartRate;
    temp = values['temperature'] ?? temp;
    setState(() {});
  }
}
