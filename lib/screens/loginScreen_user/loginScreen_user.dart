import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:remote_healthcare/alert_dialog/alert_dialog.dart';
import 'package:remote_healthcare/api_manager/api_manager.dart';
import 'package:remote_healthcare/screens/auth_screen/auth_screen.dart';
import 'package:remote_healthcare/screens/homeScreen_user/homeScreen_user.dart';
import 'package:remote_healthcare/screens/loginScreen_user/signUp_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginScreen_admin/widgets/materialBtn.dart';
import '../loginScreen_admin/widgets/textButton.dart';
import '../loginScreen_admin/widgets/textForm.dart';


class LoginScreenUser extends StatefulWidget {
  static const String routeName = 'loginPatient';

  @override
  State<LoginScreenUser> createState() => _LoginScreenUserState();
}

class _LoginScreenUserState extends State<LoginScreenUser> {
  bool isVisible = true;
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, AuthScreen.routeName);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'Welcome back to the best.\nwe\'re always here, waiting for \nyou!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white54, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFiield(
                        hint: 'Device Id',
                        controller: idController,
                        prefIcon: Icons.health_and_safety,
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Device Id must not be empty';
                          } else if (text.length < 12) {
                            return 'Device Id must be equal 12 characters';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    TextFiield(
                      hint: 'Password',
                      controller: passController,
                      prefIcon: Icons.password,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Password must not be empty';
                        } else if (text.length < 6) {
                          return 'Password must be equal 6 characters';
                        }
                        return null;
                      },
                      isVisible: isVisible,
                      suffIcon: IconButton(
                          onPressed: () {
                            isVisible = !isVisible;
                            setState(() {});
                          },
                          icon: Icon(
                            isVisible == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black45,
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    MaterialBtn(
                      'Not have an account? ',
                      'Sign up',
                      () =>                       Navigator.pushReplacementNamed(context, SignUpUser.routeName)
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                     TextButtoon('Login', () async {
                            if (formKey.currentState!.validate()) {
                              showLoading(context, 'Loading....',
                                  isCancelable: false);
                              var auth = await ApiManager.loginAccountUser(idController.text, passController.text);
                              await Future.delayed(Duration(seconds: 1), () {
                                hideLoading(context);
                              });
                              if (auth.isSuccess == true) {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('userId',auth.data?.patient?.sId??'');
                                prefs.setString('devId',auth.data?.patient?.device?.deviceId??'');
                                Navigator.pushReplacementNamed(
                                    context, HomeScreenUser.routeName,);
                              } else {
                                showMessage(context,
                                    dialogType: DialogType.error,
                                    desc: auth.message ?? '',
                                    btnOkOnPress: () {});
                              }
                            }
                          })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

