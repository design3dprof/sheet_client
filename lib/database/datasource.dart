import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

class DataSource {
  Future<void> init() async {
    await Firebase.initializeApp();
    await GetStorage.init();
  }
}