import 'package:firebase_storage/firebase_storage.dart';

class FirebaseImageData {
  final Reference fileRef;
  final String fileName;
  final String fileUrl;

  FirebaseImageData(
      {required this.fileRef, required this.fileName, required this.fileUrl});
}