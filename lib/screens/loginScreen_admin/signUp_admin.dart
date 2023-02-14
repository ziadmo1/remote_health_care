import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/loginScreen_admin.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/widgets/materialBtn.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/widgets/textButton.dart';
import 'package:remote_healthcare/screens/loginScreen_admin/widgets/textForm.dart';
import 'package:transitioner/transitioner.dart';

import '../../alert_dialog/alert_dialog.dart';
import '../../api_manager/api_manager.dart';
import '../auth_screen/auth_screen.dart';
import '../loginScreen_user/widgets/dropDownBtn.dart';

class SignUpAdmin extends StatefulWidget {
  const SignUpAdmin({Key? key}) : super(key: key);

  @override
  State<SignUpAdmin> createState() => _SignUpAdminState();
}

class _SignUpAdminState extends State<SignUpAdmin> {
  bool isVisible = true;
  String gender = 'Male';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  AppBar(
          leading: IconButton(onPressed: (){
            Transitioner(
              context: context,
              child: AuthScreen(),
              animation: AnimationType.fadeIn, // Optional value
              duration: Duration(milliseconds: 600), // Optional value
              replacement: true, // Optional value
              curveType: CurveType.ease, // Optional value
            );        }, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
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
                    controller: nameController,
                      hint: 'Full Name',
                      prefIcon: Icons.person_outline,
                      validate: (text) { if (text == null || text.trim().isEmpty) {
                        return 'Full Name must not be empty';
                      }
                      return null;}),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
            TextFiield(
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
                    controller: emailController,
                      hint: 'Email Address',
                      prefIcon: Icons.email_outlined,
                      validate: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Full Name must not be empty';
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
                  Text('Age',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 28
                    ),
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
                  MaterialBtn('Already have an account? ', 'Login',()=> Transitioner(
                    context: context,
                    child: LoginScreenAdmin(),
                    animation: AnimationType.slideRight, // Optional value
                    duration: Duration(milliseconds: 500), // Optional value
                    replacement: true, // Optional value
                    curveType: CurveType.ease, // Optional value
                  ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextButtoon('Sign Up',()async{
                    if (formKey.currentState!.validate()) {
                      showLoading(context, 'Loading....', isCancelable: false);
                      var auth = await ApiManager.createAccountAdmin(
                          emailController.text,
                          passController.text,
                          nameController.text,
                          phoneController.text,
                          gender,
                          ageController.text
                      );
                      await Future.delayed(Duration(seconds: 2), () {
                        hideLoading(context);
                      });
                      if (auth.isSuccess == true) {
                        Transitioner(
                          context: context,
                          child: LoginScreenAdmin(),
                          animation: AnimationType.slideRight, // Optional value
                          duration: Duration(milliseconds: 500), // Optional value
                          replacement: true, // Optional value
                          curveType: CurveType.ease, // Optional value
                        );
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
        ));
  }
}
