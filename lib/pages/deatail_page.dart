
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/controller/file_controller.dart';
import 'package:sheet_client/model/operation.dart';
import 'package:sheet_client/utils/styles.dart';

import '../utils/custom_widgets.dart';
import 'ciklus_page.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = "/details";

  const DetailPage({
    Key? key,
  }) : super(key: key);

  void _onItemTapped(int value) {
    switch (value) {
      case 0:
        // Navigate to Home
        Get.offAndToNamed("/home");
        break;
      case 1:
        //Send Email
        DetailPageView().sendPdfDoc();
        break;
      case 2:
        //Delete Task
        break;
      case 3:
        //Edit Task
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailPageView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Főoldal',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email_outlined,
            ),
            label: 'Küldés',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: colorGrey,
        selectedItemColor: colorDarkBlue,
        unselectedItemColor: colorBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DetailPageView extends GetView<FileController> {
  DetailPageView({Key? key}) : super(key: key);
  Operation operation = Operation();

  sendPdfDoc(){
    readImageUrl();
    const CreatePdfReport().savePdf(operation, controller.emailLista.string);
  }

  readImageUrl() {
    controller.operations.forEach((element) {
      if (element.programName.toString() == controller.fileName.string) {
        operation = element;
      }
    });
    controller.getImage();
    controller.createList(operation);
  }

  @override
  Widget build(BuildContext context) {
    readImageUrl();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => PhotoHero(
                  photo: controller.imageUrl.string,
                  height: MediaSize.screenWidth! * 0.8,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          centerTitle: true,
                          title: Text(operation.programName.toString(),
                              style: textSubTitle(colorGrey50)),
                        ),
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: boxGrey,
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.topLeft,
                              child: PhotoHero(
                                photo: controller.imageUrl.string,
                                height: MediaSize.screenWidth!,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                    operation.programName.toString() + '.png',
                                    style: textTitle(colorDarkBlue)),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
                  }),
            ),
            Text(operation.programComment.toString(),
                style: textTitle(colorDarkBlue)),
            Text(operation.programPartName.toString(),
                style: textTitle(colorDarkBlue)),
            Text("Program Time: " + operation.programCycleTime.toString(),
                style: textSubTitle(colorDarkBlue)),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: MediaSize.screenHeight! * 0.24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: operation.ciklus!.length,
                itemBuilder: (context, index) {
                  Ciklus _ciklus = operation.ciklus![index];
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaSize.screenWidth! < 800
                          ? MediaSize.screenWidth! * 0.65
                          : MediaSize.screenWidth! * 0.2,
                      child: MainCard(
                        ciklus: _ciklus,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  final Ciklus ciklus;

  const MainCard({Key? key, required this.ciklus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(CiklusPage(ciklus: ciklus));
      },
      child: Container(
        width: MediaSize.screenWidth! * 0.35,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        decoration: boxGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Operation ID: " + ciklus.operationID.toString(),
                  style: textHead(colorDarkBlue)),
              Text("Tool Number: " + ciklus.operationToolNr.toString(),
                  style: textTitle(colorGreenDark)),
              Text("Operation Desc: " + ciklus.operationDesc.toString(),
                  style: textTitle(colorGreenDark),
                  textAlign: TextAlign.center),
              Text(
                  "Operation Min Z: " +
                      ciklus.operationMinZ!.toStringAsFixed(2),
                  style: textTitle(colorGreenDark)),
              Text(
                  "Operation Max Z: " +
                      ciklus.operationMaxZ!.toStringAsFixed(2),
                  style: textTitle(colorGreenDark)),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key? key,
      required this.photo,
      required this.onTap,
      required this.height})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.cover,
              scale: 0.2,
              loadingBuilder: (context, child, loading) {
                if (loading == null) return child;
                return const Center(
                    child: CircularProgressIndicator(
                  color: colorBlue,
                  strokeWidth: 5,
                ));
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Text('Some errors occurred!'),
            ),
          ),
        ),
      ),
    );
  }
}

