import 'package:get/get.dart';

import 'package:sheet_client/controller/auth_controller.dart';
import 'package:sheet_client/controller/file_controller.dart';
//import 'package:sheet_client/controller/storage_controller.dart';


class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => FileController(), fenix: true);
    //Get.lazyPut(() => StorageController(), fenix: true);
  }
}
