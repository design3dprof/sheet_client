import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/utils/main_menu.dart';
import 'package:sheet_client/utils/styles.dart';
import 'package:sheet_client/pages/list_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Widget page;
  late String mainTitle;
  late String subTitle;

  @override
  void initState() {
    super.initState();
    mainTitle = "Setup Sheet";
    subTitle = " List";
    page = const ListPage();
  }


  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void setPage(oldal) {
    setState(() {
      page = oldal;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MainMenu(),
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: (Get.arguments != null) ? Get.arguments[1] : mainTitle,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: colorDarkBlue),
              children: <TextSpan>[
                TextSpan(
                    text: (Get.arguments != null) ? Get.arguments[2] : subTitle,
                    style: const TextStyle(color: colorOrange)),
              ],
            ),
          ),
          backgroundColor: colorGrey,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorIndigo,
                size: 24,
              ),
              onPressed: () {
                Get.offAndToNamed("/home");
              }),
          actions: [
            IconButton(
                padding: marginLogin,
                onPressed: () {
                  openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: colorIndigo,
                  size: 36,
                )),
          ],
        ),
        body: (Get.arguments != null)
            ? Container(
          child: Get.arguments[0],
        )
            : const ListPage(),
      ),
    );
  }
}
