import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/calendar_page.dart';
import '../pages/contact_page.dart';
import '../pages/deatail_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class MyRoutes {
  static const String home = HomePage.routeName;
  static const String login = LoginPage.routeName;
  static const String caledar = CalendarPage.routeName;
  static const String contacts = ContactPage.routeName;
  //static const String list = ListPage.routeName;
  static const String detail = DetailPage.routeName;

  static getRoutes(BuildContext context) {
    return {
      home: () => HomePage(),
      login: () => LoginPage(),
      caledar: () => CalendarPage(),
      contacts: () => ContactPage(),
      //list: () => ListPage(),
      detail: () => DetailPage(),
    };
  }


  static List<GetPage> getPages() {
    List<GetPage> pages = [];
    pages.add(GetPage(name: home, page: () => HomePage()));
    pages.add(GetPage(name: login, page: () => LoginPage()));
    pages.add(GetPage(name: caledar, page: () => CalendarPage()));
    pages.add(GetPage(name: contacts, page: () =>ContactPage()));
    //pages.add(GetPage(name: list, page: () => ListPage()));
    pages.add(GetPage(name: detail, page: () => DetailPage()));

    return pages;
  }
}