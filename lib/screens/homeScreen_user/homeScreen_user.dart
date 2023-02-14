import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:remote_healthcare/screens/homeScreen_user/models/HomeUserRes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_manager/api_manager.dart';
import '../auth_screen/auth_screen.dart';

class HomeScreenUser extends StatefulWidget {
  static const String routeName = 'homeUser';

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  dynamic values;
  int spo2 = 0;
  int heartRate = 0;
  String temp = '';
late SharedPreferences prefs;
getPref()async{
  prefs = await SharedPreferences.getInstance();
}
  @override
  void initState(){
  getPref();
    super.initState();
    initPush();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()async{
           await prefs.remove('userId');
           Navigator.pushReplacementNamed(
             context, AuthScreen.routeName,);
          }, icon: Icon(Icons.logout)),
          centerTitle: true,
          toolbarHeight: 70,
          title: Text('Welcome!'),
         /* actions: [
            Badge(
              shape: BadgeShape.circle,
              badgeColor: Colors.red,
              position: BadgePosition.topEnd(top: 2,end: 3),
            badgeContent: Text(values == null?'': notify.toString()),
            child: IconButton(onPressed: (){
              Navigator.pushNamed(context, NotificationScreen.routeName);
            }, icon: Icon(Icons.notifications,color: Colors.white,),
          )
            )
          ],*/
        ),
        body: FutureBuilder<HomeUserRes>(
            future: ApiManager.homeDataUser(),
            builder: (context, snapshot) {
              var patient = snapshot.data?.data?.patient;
              return Column(
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
                              values == null
                                  ? Lottie.asset('assets/activeRed.json',
                                  width: size.width * 0.06, fit: BoxFit.fill)
                                  : Lottie.asset('assets/activeGreen.json',
                                  width: size.width * 0.06, fit: BoxFit.fill),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                patient?.username ?? '',
                                textAlign: TextAlign.center,
                                style:
                                Theme
                                    .of(context)
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
                                  values == null || heartRate == -999
                                      ? Lottie.asset('assets/loading.json',
                                      width: size.width * 0.25,
                                      fit: BoxFit.fill)
                                      : Text(
                                    heartRate.toString(),
                                    style: Theme
                                        .of(context)
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
                                  values == null || spo2 == -999
                                      ? Lottie.asset('assets/loading.json',
                                      width: size.width * 0.25,
                                      fit: BoxFit.fill)
                                      : Text(
                                    spo2.toString(),
                                    style: Theme
                                        .of(context)
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
                                  values == null
                                      ? Lottie.asset('assets/loading.json',
                                      width: size.width * 0.25,
                                      fit: BoxFit.fill)
                                      : Text(
                                    double.parse(temp).toStringAsFixed(2),
                                    style: Theme
                                        .of(context)
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
                ],
              );
            }
              )
              );
  }

  initPush() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await pusher.init(
        apiKey: '17e704d4e34a2978834b',
        cluster: 'eu',
        useTLS: true,
        onEvent: onEvent
    );
    await pusher.connect();
    await pusher.subscribe(channelName: 'user-${prefs.getString('devId')}');
  }

   onEvent(PusherEvent event)async{
    values = jsonDecode(event.data);
    spo2 = values['spo2']??spo2;
    heartRate = values['heartRate']??heartRate;
    temp = values['temperature']??temp;
    setState(() {});
  }

}
