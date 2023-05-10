import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:remote_healthcare/screens/homeScreen_user/models/HomeUserRes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_manager/api_manager.dart';
import '../../themes/myTheme.dart';
import '../auth_screen/auth_screen.dart';
import '../notification_screen/notification_screen.dart';

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
  int notify = 0;
  late SharedPreferences prefs;
  getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPref();
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await prefs.remove('userId');
              Navigator.pushReplacementNamed(
                context,
                AuthScreen.routeName,
              );
            },
            icon: Icon(Icons.logout)),
        centerTitle: true,
        toolbarHeight: 70,
        title: Text('Welcome!'),
        actions: [
            Badge(
              elevation: 0,
              shape: BadgeShape.circle,
              badgeColor: notify == 0 ? Colors.transparent : Colors.red,
              position: BadgePosition.topEnd(top: 21,end: 13),
            child: IconButton(onPressed: (){
              Navigator.pushNamed(context, NotificationScreen.routeName);
            }, icon: Icon(Icons.notifications,color: Colors.white,),
          )
            )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder<HomeUserRes>(
                future: ApiManager.homeDataUser(),
                builder: (context, snapshot) {
                  var patient = snapshot.data?.data?.patient;
                  var patientAdmin = snapshot.data?.data?.patientAdmins;
                  return Column(children: [
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
                                  patient?.username ?? '',
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
                                            double.parse(temp).toStringAsFixed(2),
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
                    Card(
                      color: Colors.white,
                      elevation: 12,
                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.03),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Care Giver',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Card(
                                      color: MyTheme.lightOrange,
                                      elevation: 7,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(size.width * 0.02),
                                        width: double.infinity,
                                        height: size.height * 0.15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Name: ${patientAdmin?[index].username}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Text(
                                              'Role: ${patientAdmin?[index].role}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Text(
                                              'Email: ${patientAdmin?[index].email}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Text(
                                              'Phone Number: ${patientAdmin?[index].phoneNumber}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                itemCount: patientAdmin?.length??0
                            ),
                          ],
                        ),
                      ),
                    )
                  ]);
                }),
          ],
        ),
      ),
    );
  }

  initPush() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await pusher.init(
        apiKey: '17e704d4e34a2978834b',
        cluster: 'eu',
        useTLS: true,
        onEvent: onEvent);
    await pusher.connect();
    await pusher.subscribe(channelName: 'user-${prefs.getString('devId')}');
  }

  onEvent(PusherEvent event) async {
    values = jsonDecode(event.data);
    spo2 = values['spo2'] ?? spo2;
    heartRate = values['heartRate'] ?? heartRate;
    temp = values['temperature'] ?? temp;
    notify = values['adminsRequestsLength'] ?? notify;
    print(event);
    setState(() {});
  }
}
