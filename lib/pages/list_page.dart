import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sheet_client/controller/file_controller.dart';
import 'package:sheet_client/model/operation.dart';
import 'package:sheet_client/utils/styles.dart';
import 'package:sheet_client/pages/deatail_page.dart';

class ListPage extends GetView<FileController> {
  static const String routeName = "/list";

  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OutlinedButton.icon(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        OperationSearch(controller.operations, controller));
              },
              icon: const Icon(Icons.search_rounded),
              label: const Text("Keresés")),
          SheetListView(),
        ],
      ),
    );
  }
}

class SheetListView extends GetView<FileController> {
  SheetListView({Key? key}) : super(key: key);

  ScrollController scrollController = ScrollController();

  ugorj() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(controller.scrollPosition.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.readOperation();
    ugorj();
    return GetBuilder<FileController>(builder: (_) {
      return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              print(scrollController.position.pixels);
              controller.setScrollPosition(scrollController.offset);
            }
            return false;
          },
          child: Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.operations.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Operation operation = controller.operations[index];

                    String dimensions = "X: " +
                        operation.dimensionX!.toStringAsFixed(2) +
                        ", Y: " +
                        operation.dimensionY!.toStringAsFixed(2) +
                        ", Z: " +
                        operation.dimensionZ!.toStringAsFixed(2);

                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: MediaSize.screenWidth! < 800
                              ? MediaSize.screenWidth! * 0.85
                              : MediaSize.screenWidth! * 0.75,
                          decoration: boxGrey,
                          margin: setPaddingTop,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    operation.programName.toString(),
                                    style: textHead(colorGreenDark),
                                  ),
                                ),
                                onTap: () {
                                  controller.writeName(
                                      operation.programName.toString());
                                  controller.getImage();
                                  Get.offAndToNamed("/home", arguments: [
                                    const DetailPage(),
                                    "Operation Details ",
                                    operation.programName.toString()
                                  ]);
                                },
                              ),
                              Padding(
                                padding: setPaddingStart,
                                child: ExpansionTile(
                                  expandedAlignment: Alignment.centerLeft,
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  title: const Text(
                                    "Részletek...",
                                  ),
                                  childrenPadding: setPaddingBottom,
                                  children: [
                                    TextElem(
                                        text: operation.programComment
                                            .toString()),
                                    TextElem(
                                        text: "Time: " +
                                            operation.programCycleTime
                                                .toString()),
                                    TextElem(text: dimensions),
                                    TextElem(
                                        text: operation.programPartName
                                            .toString()),
                                    TextElem(text: operation.date.toString()),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  })));
    });
  }
}

class TextElem extends StatelessWidget {
  const TextElem({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Text(text, style: textSubTitle(colorDarkBlue)),
    );
  }
}

class OperationSearch extends SearchDelegate<String> {
  final List<Operation> operations;
  final FileController _controller;

  OperationSearch(this.operations, this._controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = " ";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          //close(context, );
          Get.offAndToNamed("/home");
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Operation> allOperations = operations
        .where((operation) => operation.programName!.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();
    return allOperations.isEmpty
        ? const Text("Nincs találat")
        : ListView.builder(
            itemCount: allOperations.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = allOperations[index].programName.toString();
                  _controller.writeName(query);
                  _controller.getImage();

                  Get.offAndToNamed("/home", arguments: [
                    const DetailPage(),
                    "Operation Details ",
                    query
                  ]);
                },
                title: Text(allOperations[index].programName.toString()),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Operation> myList = operations
        .where((operation) => operation.programName!.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();

    return myList.isEmpty
        ? const Text("Nincs találat")
        : ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = myList[index].programName.toString();
                  _controller.writeName(query);
                  _controller.getImage();

                  Get.offAndToNamed("/home", arguments: [
                    const DetailPage(),
                    "Operation Details ",
                    query
                  ]);
                },
                title: Text(myList[index].programName.toString()),
              );
            },
          );
  }
}
