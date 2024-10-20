import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClickHandler {
  void onClick(String url, String data, BuildContext context) async {
    String phoneNumber = "tel://$data";
    //String webUrl = "https://design3dprof.hu";
    String webUrl = data;
    String mailAdress = "mailto:$data";

    switch (url) {
      case "phone":
        {
          if (await canLaunchUrlString(phoneNumber)) {
            await launchUrlString(phoneNumber);
          } else {
            throw 'Could not call $phoneNumber';
          }
        }
        break;
      case "mail":
        {
          if (await canLaunchUrlString(mailAdress)) {
            print(mailAdress);
            await launchUrlString(mailAdress);
          } else {
            throw 'Could not send $mailAdress';
          }
        }
        break;
      case "web":
        {
          if (await canLaunchUrlString(webUrl)) {
            await launchUrlString(
              webUrl,
              mode: LaunchMode.inAppWebView,
              webViewConfiguration: const WebViewConfiguration(
                  headers: <String, String>{'my_header_key': 'my_header_value'})
            );
          } else {
            throw 'Could not open $webUrl';
          }
        }
        break;

      case "menu":
        Scaffold.of(context).openDrawer(); //Ez a jo
        break;
    }
  }

  void sendDataInEmail(String toMail, String subject, String body) async {
    var mailData = 'mailto:$toMail?subject=$subject&body=$body';
    {
      if (await canLaunchUrlString(mailData)) {
        await launchUrlString(mailData);
      } else {
        throw 'Could not send $toMail';
      }
    }
  }
}
