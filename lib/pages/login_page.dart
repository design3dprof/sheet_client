import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/pages/forgotpass_page.dart';
import 'package:sheet_client/pages/signup_page.dart';

import '../controller/auth_controller.dart';
import '../utils/custom_widgets.dart';
import '../utils/styles.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  late String btnLogin;
  late bool isEnabled;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void readUser() {
    isEnabled = true;
    btnLogin = "LogIn";
  }

  void showSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void logIn() {
    authController.login(emailController.text, passController.text);
  }

  @override
  Widget build(BuildContext context) {
    MediaSize().init(context);
    readUser();
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Builder(
                    builder: (context) => Padding(
                      padding: setPaddingAdd,
                      child: ListView(
                        children: [
                          Container(
                              width: MediaSize.screenWidth! * 0.5,
                              padding: setPadding,
                              margin: setPaddingTop,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaSize.screenWidth! * 0.6,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,),
                                  ),
                                  MyEditText(
                                    hintText: "Em@il címed",
                                    labelHint: "Em@il",
                                    editingController: emailController,
                                    enable: true,
                                    inputType: TextInputType.emailAddress,
                                    password: false,
                                  ),
                                  MyEditText(
                                    hintText: "Jelszó",
                                    labelHint: "Jelszó",
                                    editingController: passController,
                                    enable: true,
                                    inputType: TextInputType.visiblePassword,
                                    password: true,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      btnLogin,
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: setMargin,
                                      primary: colorDarkBlue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    onPressed: isEnabled ? logIn : null,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(onPressed: (){
                                          Get.to(const SignUpPage());
                                      }, child: const Text("Create Account")),
                                      TextButton(onPressed: (){
                                        Get.to(ForgotPassPage());
                                      }, child: const Text("Forgot Password")),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

