import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/auth_screen/auth_screen.dart';
import 'package:remote_healthcare/screens/homeScreen_admin/homeScreen_admin.dart';
import 'package:remote_healthcare/screens/homeScreen_user/homeScreen_user.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/loginScreen_admin.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/signUp_admin.dart';
import 'package:remote_healthcare/screens/loginScreen_user/loginScreen_user.dart';
import 'package:remote_healthcare/screens/loginScreen_user/signUp_user.dart';
import 'package:remote_healthcare/screens/notification_screen/notification_screen.dart';
import 'package:remote_healthcare/themes/myTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/notificationScreenAdmin/notificationScreenAdmin.dart';
import 'screens/reportsScreen/reportsScreen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? getData = prefs.getString('userId');
  String? tokenAdmin = prefs.getString('tokenAdmin');
  runApp( MyApp(getData??'',tokenAdmin??''));
}

class MyApp extends StatelessWidget {
  String token;
  String tokenAdmin;
  MyApp(this.token,this.tokenAdmin);

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.theme,
          initialRoute:token.isEmpty && tokenAdmin.isEmpty ? AuthScreen.routeName:token.isNotEmpty && tokenAdmin.isEmpty? HomeScreenUser.routeName : HomeScreenAdmin.routeName,
      routes: {
            AuthScreen.routeName : (_)=> AuthScreen(),
            HomeScreenUser.routeName : (_)=> HomeScreenUser(),
            LoginScreenAdmin.routeName : (_)=> LoginScreenAdmin(),
            LoginScreenUser.routeName : (_)=> LoginScreenUser(),
            SignUpAdmin.routeName : (_)=> SignUpAdmin(),
            SignUpUser.routeName : (_)=> SignUpUser(),
            HomeScreenAdmin.routeName : (_)=> HomeScreenAdmin(),
            NotificationScreen.routeName : (_)=> NotificationScreen(),
            NotificationAdminScreen.routeName : (_)=> NotificationAdminScreen(),
            ReportsScreen.routeName : (_)=> ReportsScreen(),
      },
    );
  }
}
