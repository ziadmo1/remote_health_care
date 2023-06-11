import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/loginScreen_user/loginScreen_user.dart';
import '../loginScreen_admin/loginScreen_admin.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/background.jpg',)
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: size.height * 0.55,),
            Container(
              padding: EdgeInsets.symmetric(vertical: size.width * 0.05,
              horizontal:size.width * 0.03
              ),
              width: double.infinity,
              height: size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Hello!',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: size.height * 0.05,),
              InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, LoginScreenUser.routeName);
                },
                child: Card(
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          width: double.infinity,
                          height: size.height * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Continue as Patient',
                              style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                      ),
              ),
                  SizedBox(height: size.height * 0.01,),
                  InkWell(
                    onTap: (){
                    Navigator.pushReplacementNamed(context, LoginScreenAdmin.routeName);
                    },
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continue as Admin',
                            style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
