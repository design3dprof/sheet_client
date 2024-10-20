import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../utils/custom_widgets.dart';
import '../utils/styles.dart';

class ForgotPassPage extends StatefulWidget {
  ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                    //width: MediaSize.screenWidth! * 0.7,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Icon(Icons.email_outlined, size: 80, color: colorDarkBlue),
                                  ),
                                  MyEditText(
                                    hintText: "Em@il címed",
                                    labelHint: "Em@il",
                                    editingController: emailController,
                                    enable: true,
                                    inputType: TextInputType.emailAddress,
                                    password: false,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  ElevatedButton(
                                    child: const Text(
                                      "Send Em@il",
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
                                    onPressed: (){
                                      if (_formKey.currentState!.validate()) {
                                        authController.sendPasswordResetEmail(
                                            emailController.text);
                                      }
                                    },
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
