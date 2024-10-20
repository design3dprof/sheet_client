import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/controller/file_controller.dart';

import '../utils/listeners.dart';
import '../utils/styles.dart';

class ContactPage extends StatelessWidget {
  static const String routeName = "/contacts";

  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactPageView(),
    );
  }
}

class ContactPageView extends GetView<FileController> {
  String email = "info@design3dprof.hu";
  String phone = "+36202817959";
  String web = "https://design3dprof.hu";
  double size = 70;

  ContactPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: setPaddingTop,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Design",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: colorDarkBlue),
              children: const <TextSpan>[
                TextSpan(text: "3DProf", style: TextStyle(color: colorOrange)),
              ],
            ),
          ),
        ),
        Container(
          width: MediaSize.screenWidth! * 0.6,
          margin: const EdgeInsets.only(bottom: 50, top: 20),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyIconButton(icon: const Icon(Icons.link), text: "Web Page", link: "web"),
            MyIconButton(icon: const Icon(Icons.email_rounded), text: "Em@il", link: "mail"),
            MyIconButton(icon: const Icon(Icons.call), text: "Phone", link: "phone"),
          ],
        )
      ],
    );
  }
}

class MyIconButton extends StatelessWidget {

  MyIconButton({Key? key, required this.icon, required this.text, required this.link})
      : super(key: key);
  final Widget icon;
  final String text;
  double size = 70;
  final String link;

  String email = "info@design3dprof.hu";
  String phone = "+36202817959";
  String web = "https://design3dprof.hu";

  void _onItemTapped(url, context) {
    switch (url) {
      case 0:
        ClickHandler().onClick("web", web, context);
        break;
      case 1:
        ClickHandler().onClick("mail", email, context);
        break;
      case 2:
        ClickHandler().onClick("phone", phone, context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              _onItemTapped(link, context);
            },
            icon: icon,
          iconSize: size,
          color: colorIndigo,
        ),
        Text(text),
      ],
    );
  }
}
