import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:sheet_client/model/operation.dart';
import 'package:sheet_client/utils/styles.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfwidget;

import '../controller/file_controller.dart';
import '../pages/pdf_page.dart';
import 'date_helper.dart';

class MyEditText extends StatelessWidget {
  final String hintText;
  final String labelHint;
  final TextEditingController editingController;
  final bool enable;
  final TextInputType inputType;
  final bool password;

  const MyEditText(
      {Key? key,
      required this.hintText,
      required this.labelHint,
      required this.editingController,
      required this.enable,
      required this.inputType,
      required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaSize.screenWidth! * 0.6,
      margin: marginLogin,
      child: Padding(
        padding: marginHorizontal,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          obscureText: password,
          enableSuggestions: !password,
          autocorrect: !password,
          enabled: enable,
          controller: editingController,
          keyboardType: inputType,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.singleLineFormatter
          ],
          style: textSubTitle(colorDarkBlue),
          decoration: InputDecoration(
              labelText: labelHint,
              labelStyle: textSubTitle(colorDarkBlue),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
        ),
      ),
    );
  }
}

class MyTextRow extends StatelessWidget {
  const MyTextRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CreatePdfReport extends StatelessWidget {
  const CreatePdfReport({Key? key}) : super(key: key);

  Future<String> get _localPath async {
    final externalDirectory = await getExternalStorageDirectory();
    return externalDirectory!.absolute.path;
    //final directory = await getApplicationDocumentsDirectory();
    //return directory.absolute.path;
  }

  savePdf(Operation operation, String listas) async {
    FileController controller = Get.find();
    final pdf = pdfwidget.Document(deflate: io.zlib.encode);
    final path = await _localPath;
    final oxygen =
        pdfwidget.Font.ttf(await rootBundle.load('fonts/Oxygen-Regular.ttf'));
    String date = DateHelper().getDay;

    final theme = pdfwidget.ThemeData.withFont(
      base:
          pdfwidget.Font.ttf(await rootBundle.load('fonts/Oxygen-Regular.ttf')),
    );

    String fullPath = "$path/" + operation.programName.toString() + ".pdf";
    final netImage = await networkImage(controller.imageUrl.string);

    try {
      pdf.addPage(pdfwidget.MultiPage(
        pageFormat: PdfPageFormat.a4,
        maxPages: 200,
        theme: theme,
        build: (pdfwidget.Context context) => <pdfwidget.Widget>[
          pdfwidget.SizedBox(
              height: MediaSize.screenHeight! * 0.8,
              child: pdfwidget.Column(
                  mainAxisAlignment: pdfwidget.MainAxisAlignment.center,
                  mainAxisSize: pdfwidget.MainAxisSize.min,
                  children: [
                    pdfwidget.Expanded(
                      child: pdfwidget.Row(
                          mainAxisAlignment:
                              pdfwidget.MainAxisAlignment.spaceBetween,
                          children: [
                            pdfwidget.Padding(
                                padding:
                                    const pdfwidget.EdgeInsets.only(left: 20),
                                child: pdfwidget.Text(
                                  operation.programName.toString(),
                                  style: pdfwidget.TextStyle(
                                      font: oxygen,
                                      fontSize: 30,
                                      fontWeight: pdfwidget.FontWeight.bold),
                                )),
                            pdfwidget.BarcodeWidget(
                              color: PdfColor.fromHex("#000646"),
                              data: 'http://design3dprof.hu',
                              width: 80,
                              height: 80,
                              barcode: pdfwidget.Barcode.qrCode(),
                              drawText: false,
                            ),
                          ]),
                    ),
                    pdfwidget.Divider(
                      thickness: 4,
                    ),
                    PdfTextLine(
                        "Created by: " + operation.program.toString(), oxygen),
                    PdfTextLine(operation.programName.toString(), oxygen),
                    PdfTextLine(operation.programComment.toString(), oxygen),
                    PdfTextLine(operation.programPartName.toString(), oxygen),
                    PdfTextLine(
                        "Program Cycle Time: " +
                            operation.programCycleTime.toString(),
                        oxygen),
                    PdfTextLine(
                        "Dimension X: " +
                            operation.dimensionX!.toStringAsFixed(2),
                        oxygen),
                    PdfTextLine(
                        "Dimension Y: " +
                            operation.dimensionY!.toStringAsFixed(2),
                        oxygen),
                    PdfTextLine(
                        "Dimension Z: " +
                            operation.dimensionZ!.toStringAsFixed(2),
                        oxygen),
                    pdfwidget.SizedBox(height: 30),
                    pdfwidget.Divider(thickness: 4),
                    pdfwidget.Align(
                        alignment: pdfwidget.Alignment.centerLeft,
                        child: pdfwidget.Text(
                          date,
                          style:
                              pdfwidget.TextStyle(font: oxygen, fontSize: 16),
                        )),
                    pdfwidget.SizedBox(height: 15),
                  ])),
          //),

          pdfwidget.SizedBox(
              height: MediaSize.screenHeight! * 0.7,
              child: pdfwidget.Transform.scale(
                scale: 2.0,
                child: pdfwidget.Container(
                  decoration: pdfwidget.BoxDecoration(
                      image: pdfwidget.DecorationImage(
                    image: netImage,
                    fit: pdfwidget.BoxFit.fitWidth,
                  )),
                ),
              )),

          pdfwidget.Wrap(
            children: List<pdfwidget.Widget>.generate(operation.ciklus!.length,
                (int index) {
              final sor = operation.ciklus![index];
              var itemList = [];
              sor.toJson().forEach((key, value) {
                itemList.add(CiklusItem(title: key, value: value.toString()));
              });

              return pdfwidget.Container(
                child: pdfwidget.Column(
                  children: <pdfwidget.Widget>[
                    pdfwidget.Header(
                        text: sor.operationID.toString(),
                        title: "Operation ID",
                        textStyle:
                            pdfwidget.TextStyle(font: oxygen, fontSize: 20)),
                    pdfwidget.ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          CiklusItem elem = itemList[index];
                          return pdfwidget.Row(
                              mainAxisAlignment:
                                  pdfwidget.MainAxisAlignment.spaceBetween,
                              children: [
                                pdfwidget.Container(
                                    height: 30,
                                    padding: const pdfwidget.EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: pdfwidget.Text(elem.title.toString(),
                                        style: pdfwidget.TextStyle(
                                            font: oxygen,
                                            fontSize: 18,
                                            color: PdfColor.fromHex("#000646"),
                                            fontWeight:
                                                pdfwidget.FontWeight.bold))),
                                pdfwidget.Container(
                                    height: 30,
                                    padding: const pdfwidget.EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: pdfwidget.Text(elem.value.toString(),
                                        style: pdfwidget.TextStyle(
                                            font: oxygen,
                                            fontSize: 18,
                                            color: PdfColor.fromHex("#000646"),
                                            fontWeight:
                                                pdfwidget.FontWeight.bold))),
                              ]);
                        }),
                  ],
                ),
              );
            }),
          ),
        ],
      ));
    } catch (e, s) {
      print(s);
    }

    navigateToPdfView(pdf, fullPath);
  }

  navigateToPdfView(pdf, fullPath) async {
    final filePdf = io.File(fullPath);
    try {
      await filePdf.writeAsBytes(await pdf.save());
      //print(fullPath.toString());
      Get.snackbar('PDF saved', 'The PDF Setup Sheet saved $fullPath.');
      Get.to(() => PdfViewPage(
            path: filePdf.path,
            attachments: [filePdf.path],
          ));
    } catch (e) {
      Get.snackbar('PDF create', 'The PDF Setup Sheet could not create');
      //print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

pdfwidget.Widget PdfTextLine(text, font) {
  return pdfwidget.Container(
      height: 40,
      padding: pdfwidget.EdgeInsets.only(top: 10, bottom: 10),
      child: pdfwidget.Text(
        text,
        style: pdfwidget.TextStyle(font: font, fontSize: 18),
      ));
}
