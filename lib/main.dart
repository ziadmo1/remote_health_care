import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/auth_screen/auth_screen.dart';
import 'package:remote_healthcare/screens/homeScreen_admin/homeScreen_admin.dart';
import 'package:remote_healthcare/screens/homeScreen_user/homeScreen_user.dart';
import 'package:remote_healthcare/screens/loginScreen_user/loginScreen_user.dart';
import 'package:remote_healthcare/screens/notification_screen/notification_screen.dart';
import 'package:remote_healthcare/themes/myTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? getData = prefs.getString('userId');
  runApp( MyApp(getData??''));
}

class MyApp extends StatelessWidget {
  String token;
  MyApp(this.token);

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.theme,
          initialRoute:token.isEmpty ? AuthScreen.routeName:HomeScreenUser.routeName,
      routes: {
            AuthScreen.routeName : (_)=> AuthScreen(),
            HomeScreenUser.routeName : (_)=> HomeScreenUser(),
            HomeScreenAdmin.routeName : (_)=> HomeScreenAdmin(),
            NotificationScreen.routeName : (_)=> NotificationScreen(),
      },
    );
  }
}
