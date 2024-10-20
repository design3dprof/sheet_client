import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../model/operation.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  //Read Operation from Firesore
  Future<List<Operation>> readSheetFire() async {
    List<Operation> operationList = [];
    Operation? operation;
    try {
      await _firestore
          .collection('operations')
          .orderBy("Date", descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {

        querySnapshot.docs.forEach((doc) {
          List<Ciklus> ciklusok = [];

          doc['ciklus'].forEach((elem) {
            Ciklus ciklus = Ciklus(
              operationID: elem['Operation ID'],
              operationDesc: elem['Operation Desc'],
              operationToolNr: elem['Operation Tool Nr'],
              operationToolDesc: elem['Operation Tool Desc'],
              operationTime: elem['Operation Time'],
              operationSpeed: checkDouble(elem['Operation Speed']),
              operationFeed: checkDouble(elem['Operation Feed']),
              operationMaxZ: checkDouble(elem['Operation Max Z']),
              operationMinZ: checkDouble(elem['Operation Min Z']),
              operationStockToLeaveXY: checkDouble(elem['Operation Stock To Leave XY']),
              operationStockToLeaveZ: checkDouble(elem['Operation Stock To Leave Z']),
              strategy: elem['Operation Strategy'],
              tolerance: checkDouble(elem['Operation Tolerance']),
              coolant: elem['Coolant'],
              toolDiameter: checkDouble(elem['Tool Diameter']),
              cornerRadius: checkDouble(elem['Tool Corner Radius']),
              toolType: elem['Tool Type'],
              maxStepdown: checkDouble(elem['Maximum Stepdown']),
              maxStepover: checkDouble(elem['Maximum Stepover']),
              cuttingDistance: checkDouble(elem['Cutting Distance']),
              rapidDistance: checkDouble(elem['Rapid Distance']),
              notes: elem['Operation Notes'],
            );
            ciklusok.add(ciklus);
          });

          operation = Operation(
            program: doc['Program'],
            programName: doc["Program Name"],
            programPartName: doc["Program Part Name"],
            programComment: doc["Program Comment"],
            programCycleTime: doc["Program Cycle Time"],
            dimensionX: checkDouble(doc['Dimension X']),
            dimensionY: checkDouble(doc['Dimension Y']),
            dimensionZ: checkDouble(doc['Dimension Z']),
            date: doc["Date"],
            user: doc['User'],
            ciklus: ciklusok,
          );
          operationList.add(operation!);
        });
      });
    } catch (e) {
      Get.snackbar('Read Data Error', '$e');
      //print(e);
    }
    return operationList;
  }


  static double checkDouble(dynamic value) {
    return value is int ? value.toDouble() : value;
  }

  readImageFire(name) async {
    String imageUrl = await FirebaseStorage.instance
        .ref('/images')
        .child(name)
        .getDownloadURL();
    return imageUrl;
  }
}
