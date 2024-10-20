import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sheet_client/model/operation.dart';
import 'package:sheet_client/database/database.dart';

class FileController extends GetxController {
  RxString fileName = "".obs;
  RxString imageUrl = "".obs;
  RxString emailLista = "".obs;
  RxList<String> fileNames = <String>[].obs;
  late RxList<CiklusItem> _itemList;
  late RxList<Operation> _operations;
  RxDouble scrollPosition = 0.0.obs;
  RxBool isVisible = true.obs;

  List<Operation> get operations => _operations;
  List<CiklusItem> get ciklusItems => _itemList;

  FileController() {
    _operations = <Operation>[].obs;
    _itemList = <CiklusItem>[].obs;
    readOperation();
    update();
  }


  @override
  void dispose() {
    super.dispose();
  }

  setScrollPosition(value){
    print(value.toString() + " itten");
    scrollPosition.value = value;
    update();
  }

  setOperations(operation) {
    _operations.add(operation);
    update();
  }

  clearOperations() {
    _operations.clear();
    operations.clear();
    update();
  }

  addOperation(Operation operation) {
    //Database().addSheetFire(operation);
    update();
  }

  deleteOperation(Operation operation) {
    //Database().deletSheetFire(operation);
    update();
  }

  readOperation() async {
    _operations.value = await Database().readSheetFire();
    update();
  }

  getImage() async {
    String name = fileName.string + '.png';
    imageUrl.value = await Database().readImageFire(name);
    update();
  }

  setFileNames(element) {
    fileNames.add(element);
    update();
  }

  clearFileNames() {
    fileNames.clear();
    clearOperations();
    update();
  }

  writeName(string) {
    fileName.value = string;
    update();
  }

  createList(Operation operation) {
    var teljes = StringBuffer();
    teljes.writeln("Program - " + operation.program.toString());
    teljes.writeln("Program neve - " + operation.programName.toString());
    teljes.writeln("Modell neve - " + operation.programPartName.toString());
    teljes.writeln("Megjegyzés - " + operation.programComment.toString());
    teljes.writeln("Program idő - " + operation.programCycleTime.toString());
    teljes.writeln("Előgyártmány X - " + operation.dimensionX.toString());
    teljes.writeln("Előgyártmány Y - " + operation.dimensionY.toString());
    teljes.writeln("Előgyártmány Z - " + operation.dimensionZ.toString());
    teljes.writeln("Dátum - " + operation.date.toString());
    teljes.writeln("Létrehozta - " + operation.user.toString());
    teljes.writeln('');

    for (var element in operation.ciklus!) {
      teljes.writeln("Ciklus ID - " + element.operationID.toString());
      teljes.writeln("Ciklus neve - " + element.operationDesc.toString());
      teljes.writeln("Szerszám - " + element.operationToolNr.toString());
      teljes.writeln(
          "Szerszám megnevezés - " + element.operationToolDesc.toString());
      teljes.writeln(
          "Ráhagyás XY - " + element.operationStockToLeaveXY.toString());
      teljes
          .writeln("Ráhagyás Z - " + element.operationStockToLeaveZ.toString());
      teljes.writeln("Max Z - " + element.operationMaxZ.toString());
      teljes.writeln("Min Z - " + element.operationMinZ.toString());
      teljes.writeln("Fordulat - " + element.operationSpeed.toString());
      teljes.writeln("Előtolás - " + element.operationFeed.toString());
      teljes.writeln("Ciklus idő - " + element.operationTime.toString());
      teljes.writeln("Szerszám típusa - " + element.toolType.toString());
      teljes.writeln("Művelet - " + element.strategy.toString());
      teljes.writeln("Tűrés - " + element.tolerance.toString());
      teljes.writeln("Hűtés - " + element.coolant.toString());
      teljes.writeln("Szerszám átmérő - " + element.toolDiameter.toString());
      teljes.writeln("Sarok rádiusz - " + element.cornerRadius.toString());
      teljes.writeln("Max fogás - " + element.maxStepdown.toString());
      teljes.writeln("Max oldallépés - " + element.maxStepover.toString());
      teljes.writeln("Forgácsolási út - " + element.cuttingDistance.toString());
      teljes.writeln("Gyorsjárati út - " + element.rapidDistance.toString());
      teljes.writeln("Megjegyzés - " + element.notes.toString());

      teljes.writeln('');
    }

    emailLista.value = teljes.toString();
  }

  createCiklusItemList(Ciklus ciklus){
    _itemList.clear();
    ciklus.toJson().forEach((key, value) {
      _itemList.add(CiklusItem(title: key, value: value.toString()));
    });
    update();
  }

  changeSwitch(int szam){
    ciklusItems[szam].isSelected = !ciklusItems[szam].isSelected;
    if(!_itemList[szam].isSelected){
      isVisible.value = _itemList[szam].isSelected;
    }
    update();
  }

  setVisible(){
    for (var element in ciklusItems) {
      element.isSelected = isVisible.value;
    }
    update();
  }

  setVisibility(){
    isVisible.value = !isVisible.value;
    update();
  }

}
