import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/file_controller.dart';
import '../model/operation.dart';
import '../utils/styles.dart';

class CycleElement extends GetView<FileController> {
  final int index;

  const CycleElement({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileController>(builder: (_) {
      return ListTile(
        title: Text(controller.ciklusItems[index].title.toString()),
        subtitle: Text(controller.ciklusItems[index].value.toString()),
        trailing: Checkbox(
            value: controller.ciklusItems[index].isSelected,
            onChanged: (value) {
              controller.changeSwitch(index);
            }),
      );
    });
  }
}

class CiklusPage extends GetView<FileController> {
  final Ciklus ciklus;

  const CiklusPage({Key? key, required this.ciklus}) : super(key: key);

  readNotes() {
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.createCiklusItemList(ciklus);
      var text = ciklus.notes.toString().runes.toList();
      return utf8.decode(text);
    });
  }

  openDialog() {
    Get.defaultDialog(
        title: "Set Cycle List",
        content: SizedBox(
          width: MediaSize.screenWidth! * 0.8,
          height: MediaSize.screenHeight! * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() => ListTile(
                    title: const Text("Select all"),
                    trailing: Checkbox(
                        value: controller.isVisible.value,
                        onChanged: (value) {
                          controller.setVisibility();
                          controller.setVisible();
                        }),
                  )),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.ciklusItems.length,
                    itemBuilder: (context, index) {
                      return CycleElement(
                        index: index,
                      );
                    }),
              ),
            ],
          ),
        ),
        backgroundColor: colorBlueGrey,
        titleStyle: TextStyle(color: colorDarkBlue),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () {
                controller.onInit();
                Get.back();
              },
              child: const Text("Ok")),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    readNotes();
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
              Navigator.of(context).pop();
            }),
        title: Text(ciklus.operationDesc.toString(),
            style: textSubTitle(colorGrey50)),
        actions: [
          IconButton(
              padding: paddingRight,
              onPressed: () {
                openDialog();
              },
              icon: Icon(
                Icons.settings,
                color: colorGrey50,
                size: 30,
              )),
        ],
      ),
      body: GetBuilder<FileController>(builder: (_) {
        return ListView.builder(
            itemCount: controller.ciklusItems.length,
            itemBuilder: (context, index) {
              CiklusItem ciklusItem = controller.ciklusItems[index];
              return CardElement(
                title: ciklusItem.title,
                subtitle: ciklusItem.value,
                isVisible: ciklusItem.isSelected,
              );
            });
      }),
    );
  }
}

class CardElement extends StatelessWidget {
  const CardElement(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.isVisible})
      : super(key: key);
  final String title;
  final String subtitle;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Card(
          child: ListTile(
            title: Text(title, style: textHead(colorDarkBlue)),
            subtitle: Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(subtitle, style: textTitle(colorGreenDark))),
          ),
          elevation: 4,
          shadowColor: colorGreenDark,
        ),
      ),
    );
  }
}
