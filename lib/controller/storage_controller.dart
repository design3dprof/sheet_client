
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sheet_client/model/operation.dart';

const String dataBox = "operations"; // Operation parameters

class StorageController extends GetxController{

  final box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void storeData(List<Operation> models) {
    box.write(dataBox, models);
    box.listen((){
      print('box changed');
    });
  }

  List<Operation> restoreData() {
    List<Operation> models = [];

    final map = box.read(dataBox);

    models = map as List<Operation>;

    //map.forEach((value) {
      //models.add(Operation.fromJson(element));
      //models.add(value);
    //});

    print(models.length.toString() + " GetStorage length");

    return models;
    //return Operation.fromJson(map);
  }




}