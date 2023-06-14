import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:remote_healthcare/alert_dialog/alert_dialog.dart';
import 'package:remote_healthcare/api_manager/api_manager.dart';
import 'package:remote_healthcare/screens/loginScreen_user/loginScreen_user.dart';
import 'package:remote_healthcare/screens/loginScreen_user/widgets/dropDownBtn.dart';
import '../auth_screen/auth_screen.dart';
import '../loginScreen_admin/widgets/materialBtn.dart';
import '../loginScreen_admin/widgets/textButton.dart';
import '../loginScreen_admin/widgets/textForm.dart';

class SignUpUser extends StatefulWidget {
  static const String routeName = 'createPatient';

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  bool isVisible = true;
  String gender = 'Male';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AuthScreen.routeName);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'You are where you find the\nbest you are looking for!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white54, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFiield(
                      hint: 'Full Name',
                      keyboard: TextInputType.name,
                      prefIcon: Icons.person_outline,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      controller: nameController,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    TextFiield(
                      keyboard: TextInputType.phone,
                      hint: 'Phone Number',
                      prefIcon: Icons.phone,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Phone Number must not be empty';
                        }
                        return null;
                      },
                      controller: phoneController,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    TextFiield(
                        keyboard: TextInputType.number,
                        controller: idController,
                        hint: 'Device Id',
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
                      controller: passController,
                      hint: 'Password',
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
                      height: size.height * 0.015,
                    ),
                    Text(
                      'Age',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 28),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    TextFiield(
                      controller: ageController,
                      hint: 'Age',
                      keyboard: TextInputType.number,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Age must not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    DropDownBtn(gender),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    MaterialBtn(
                        'Already have an account? ',
                        'Login',
                        () => Navigator.pushReplacementNamed(
                            context, LoginScreenUser.routeName)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextButtoon('Sign Up', () async {
                      if (formKey.currentState!.validate()) {
                        showLoading(context, 'Loading....',
                            isCancelable: false);
                        var auth = await ApiManager.createAccountUser(
                            idController.text,
                            passController.text,
                            nameController.text,
                            phoneController.text,
                            gender,
                            ageController.text);
                        await Future.delayed(Duration(seconds: 2), () {
                          hideLoading(context);
                        });
                        if (auth.isSuccess == true) {
                          Navigator.pushReplacementNamed(
                              context, LoginScreenUser.routeName);
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
