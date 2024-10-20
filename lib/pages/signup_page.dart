import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/controller/auth_controller.dart';
import 'package:sheet_client/utils/custom_widgets.dart';
import 'package:sheet_client/utils/styles.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/signup";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  late String btnLogin;
  late bool isEnabled;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void readUser() {
    isEnabled = true;
    btnLogin = "Sign Up";
  }

  void logIn() {
    authController.createAdmin(nameController.text, emailController.text, passController.text);
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
                                    child: Icon(Icons.emoji_people_outlined, size: 80, color: colorDarkBlue),
                                  ),
                                  MyEditText(
                                    hintText: "Teljes név",
                                    labelHint: "Neved",
                                    editingController: nameController,
                                    enable: true,
                                    inputType: TextInputType.name,
                                    password: false,
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
                                      style: TextStyle(fontSize: 28),
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
