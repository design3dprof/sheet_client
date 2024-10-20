import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../utils/styles.dart';

class PdfViewPage extends StatefulWidget {
  static const String routeName = "/pdf";

  //final PDFDocument path;
  final String path;
  final List<String> attachments;

  PdfViewPage({Key? key, required this.path, required this.attachments})
      : super(key: key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  late String platformResponse;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Navigate to Home
        Get.offAndToNamed("/home");
        break;
      case 1:
        //Send Pdf
        send();
        Get.snackbar('Send email', 'Elküldve a pdf!');
        break;
    }
  }

  Future<void> send() async {
    final Email email = Email(
      body: "Pdf from Setup Sheet Client app",
      subject: "Setup Sheet",
      recipients: [" "],
      attachmentPaths: widget.attachments,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      setState(() {
        platformResponse = 'Elküldve a pdf!';
      });
    } catch (error) {
      setState(() {
        platformResponse = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //setDocument();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorGrey50,
              size: 24,
            ),
            onPressed: () {
              Get.back();
              //Navigator.of(context).pop();
            }),
        title: Text("PDF Page",
            style: textSubTitle(colorGrey50)),
      ),
      body: Center(
        child: PDFView(
                filePath: widget.path,
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Főoldal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Küldés',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
