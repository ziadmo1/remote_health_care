import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:remote_healthcare/api_manager/api_manager.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/models/AuthAdminRes.dart';
import 'package:remote_healthcare/screens/searchScreen/searchScreen.dart';
import 'package:remote_healthcare/themes/myTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_screen/auth_screen.dart';
import '../notificationScreenAdmin/notificationScreenAdmin.dart';
import '../reportsScreen/reportsScreen.dart';


class HomeScreenAdmin extends StatefulWidget {
  static const String routeName = 'admin';

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  SharedPreferences? preferences;
  prefData()async{
    preferences = await SharedPreferences.getInstance();
  }
  List<Patients>? patients;
  int index = 0;
  loading(){
    index++;
    setState(() {

    });
  }
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),() => loading(),);
    prefData();
   oneSignal();
    super.initState();
  }
  String? id;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: ()async{
          await OneSignal.shared.disablePush(true);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('tokenAdmin');
          Navigator.pushReplacementNamed(
            context, AuthScreen.routeName,);
        }, icon: Icon(Icons.logout)),

        centerTitle: true,
        toolbarHeight: 70,
        title: Text('Welcome!'),
        actions: [
           IconButton(onPressed: ()async{
            await Navigator.pushNamed(context, NotificationAdminScreen.routeName,arguments:preferences?.getString('tokenAdmin'));
            }, icon: Icon(Icons.notifications,color: Colors.white,),
          ),
        ],
      ),
      body: FutureBuilder<AuthAdminRes>(
        future: ApiManager.dataAdmin(preferences?.getString('tokenAdmin')??''),
        builder: (context, snapshot) {
          var admin = snapshot.data?.data?.admin;
          patients = admin?.patients;
          id = admin?.sId;
          return index == 0 ?Center(child: CircularProgressIndicator(color: Colors.white,)) : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:  EdgeInsets.all(size.width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Hey! ${admin?.username}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 28
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Card(
                    color: Colors.white,
                    elevation: 12,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.03),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Your Patients',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: (){
                                    showSearch(context: context, delegate: PatientsSearch(admin?.email??''),);
                                  }, icon: Icon(Icons.add,color: MyTheme.lightOrange,size: 30,)),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02,),
                          patients?.length == 0? Column(
                            children: [
                              Icon(Icons.person,size: 100,),
                              SizedBox(height: 5,),
                              Text('You don\'t have any patient.',style: TextStyle(
                                  fontSize: 16
                              ),)
                            ],
                          ) :
                          ListView.separated(
                            shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction)async{
                                  await ApiManager.deleteAdmin(phone: patients?[index].phoneNumber??'',adminEmail: admin?.email??'');
                                  setState(() {

                                  });
                                },
                                background: Container(
                                  padding: EdgeInsets.only(left: 50),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Text('Delete',style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                child: Card(
                                  color: MyTheme.lightOrange,
                                  elevation: 7,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(size.width * 0.02),
                                    width: double.infinity,
                                    height: size.height * 0.15,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: size.width * 0.65,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text('Name: ${admin?.patients![index].username?.toUpperCase()??''}',
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.01,),
                                              Text('Gender: ${admin?.patients![index].gender?.toUpperCase()??''}',
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.01,),
                                              Text('Age: ${admin?.patients![index].age??''}',
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.01,),
                                              Text('Phone Number: ${admin?.patients![index].phoneNumber??''}',
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(onPressed: (){
                                          Navigator.pushNamed(context, ReportsScreen.routeName,arguments: admin?.patients?[index]);
                                        },
                                            icon: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(height: size.height * 0.02,),
                              itemCount: admin?.patients!.length??0
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
  )
    );
  }
  oneSignal()async{
   await OneSignal.shared.setAppId("fe711cfd-661b-452b-9d63-9e9d4cf56e44");
   await OneSignal.shared.disablePush(false);
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
   await OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
      return navNotify(result);
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
        event.complete(event.notification);
    });
  }
  void navNotify(OSNotificationOpenedResult result)async{
    if(result.notification.body == 'Fall Detected') {
      await Navigator.pushNamed(context, NotificationAdminScreen.routeName,
          arguments: preferences?.getString('tokenAdmin'));
    }
  }
}

