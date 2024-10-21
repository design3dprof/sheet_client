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

        operationList = querySnapshot.docs
            .map((doc) => Operation.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      Get.snackbar('Read Data Error', '$e');
      //print(e);
    }
    return operationList;
  }

  readImageFire(name) async {
    String imageUrl = await FirebaseStorage.instance
        .ref('/images')
        .child(name)
        .getDownloadURL();
    return imageUrl;
  }
}
