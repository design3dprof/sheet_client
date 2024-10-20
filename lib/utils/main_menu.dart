import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/pages/calendar_page.dart';
import 'package:sheet_client/pages/contact_page.dart';
import 'package:sheet_client/pages/list_page.dart';
import 'package:sheet_client/controller/auth_controller.dart';
import 'package:sheet_client/utils/styles.dart';


class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: setPaddingTop,
      width: 120,
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuItem(
                icon: Icons.home,
                text: "Home",
                widget: Container(),
                titleMain: "",
                titleSub: "",
                index: 0,
              ),
              const MenuItem(
                icon: Icons.list_alt,
                text: "File\nList",
                widget: ListPage(),
                index: 1,
                titleMain: 'File ',
                titleSub: 'List',
              ),
              MenuItem(
                icon: Icons.calendar_today_rounded,
                text: "Calendar",
                widget: CalendarPage(),
                index: 2,
                titleMain: 'File ',
                titleSub: 'List',
              ),
              const MenuItem(
                icon: Icons.contacts,
                text: "Contacts",
                widget: ContactPage(),
                index: 3,
                titleMain: 'Contact ',
                titleSub: 'Page',
              ),
              const MenuItem(
                icon: Icons.logout_rounded,
                text: "Log Out",
                //widget: LoginPage(),
                index: 4,
                titleMain: 'Log ',
                titleSub: 'Out',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? widget;
  final String titleMain;
  final String titleSub;
  final int index;

  const MenuItem(
      {Key? key,
        required this.icon,
        required this.text,
        this.widget,
        required this.index,
        required this.titleMain,
        required this.titleSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (text) {
          case "Home":
            {
              Get.offAndToNamed("/home");
              //ClickHandler().onClick("web", "https://design3dprof.com/", context);
            }
            break;
          case "Log Out":
            AuthController controller = Get.find();
            controller.logOut();
            break;
          default:
            {
              if (widget != null) {
                Get.offAndToNamed("/home",
                    arguments: [widget, titleMain, titleSub]);
              }
            }
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}