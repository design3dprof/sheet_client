
import 'dart:convert';

class Operation {
  String? program;
  String? programName;
  String? programPartName;
  String? programComment;
  String? programCycleTime;
  double? dimensionX;
  double? dimensionY;
  double? dimensionZ;
  String? user;
  String? date;
  List<Ciklus>? ciklus;

  Operation(
      {this.program,
        this.programName,
        this.programPartName,
        this.programComment,
        this.programCycleTime,
        this.dimensionX,
        this.dimensionY,
        this.dimensionZ,
        this.user,
        this.date,
        this.ciklus});

  Operation.fromJson(Map<String, dynamic> json) {
    program = json['Program'];
    programName = json['Program Name'];
    programPartName = json['Program Part Name'];
    programComment = json['Program Comment'];
    programCycleTime = json['Program Cycle Time'];
    dimensionX = json['Dimension X'];
    dimensionY = json['Dimension Y'];
    dimensionZ = json['Dimension Z'];
    user = json['User'];
    date = json['Date'];
    if (json['ciklus'] != null) {
      ciklus = <Ciklus>[];
      json['ciklus'].forEach((v) {
        ciklus!.add(Ciklus.fromJson(v));
      });
    }
  }
  static List<Operation> listFromJson(list) =>
      List<Operation>.from(list.map((x) => Operation.fromJson(x)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Program'] = program;
    data['Program Name'] = programName;
    data['Program Part Name'] = programPartName;
    data['Program Comment'] = programComment;
    data['Program Cycle Time'] = programCycleTime;
    data['Dimension X'] = dimensionX;
    data['Dimension Y'] = dimensionY;
    data['Dimension Z'] = dimensionZ;
    data['User'] = user;
    data['Date'] = date;
    if (ciklus != null) {
      data['ciklus'] = ciklus!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class Ciklus {
  int? operationID;
  String? operationToolNr;
  String? strategy;
  double? tolerance;
  String? coolant;
  double? toolDiameter;
  double? cornerRadius;
  String? toolType;
  String? operationDesc;
  String? operationToolDesc;
  double? maxStepdown;
  double? maxStepover;
  double? cuttingDistance;
  double? rapidDistance;
  double? operationMinZ;
  double? operationMaxZ;
  String? operationTime;
  double? operationStockToLeaveXY;
  double? operationStockToLeaveZ;
  double? operationSpeed;
  double? operationFeed;
  String? notes;

  Ciklus(
      {this.operationID,
        this.operationToolNr,
        this.strategy,
        this.tolerance,
        this.coolant,
        this.toolDiameter,
        this.cornerRadius,
        this.toolType,
        this.operationDesc,
        this.operationToolDesc,
        this.maxStepdown,
        this.maxStepover,
        this.cuttingDistance,
        this.rapidDistance,
        this.operationMinZ,
        this.operationMaxZ,
        this.operationTime,
        this.operationStockToLeaveXY,
        this.operationStockToLeaveZ,
        this.operationSpeed,
        this.operationFeed,
        this.notes
      });

  Ciklus.fromJson(Map<String, dynamic> json) {
    operationID = json['Operation ID'];
    operationToolNr = json['Operation Tool Nr'];
    strategy = json['Operation Strategy'];
    tolerance = json['Operation Tolerance'];
    coolant = json['Coolant'];
    toolDiameter = json['Tool Diameter'];
    cornerRadius = json['Tool Corner Radius'];
    toolType = json['Tool Type'];
    operationDesc = json['Operation Desc'];
    operationToolDesc = json['Operation Tool Desc'];
    maxStepdown = json['Maximum Stepdown'];
    maxStepover = json['Maximum Stepover'];
    cuttingDistance = json['Cutting Distance'];
    rapidDistance = json['Rapid Distance'];
    operationMinZ = json['Operation Min Z'];
    operationMaxZ = json['Operation Max Z'];
    operationTime = json['Operation Time'];
    operationStockToLeaveXY = json['Operation Stock To Leave XY'];
    operationStockToLeaveZ = json['Operation Stock To Leave Z'];
    operationSpeed = json['Operation Speed'];
    operationFeed = json['Operation Feed'];
    notes = json['Operation Notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Operation ID'] = operationID;
    data['Operation Tool Nr'] = operationToolNr;
    data['Operation Strategy'] = strategy;
    data['Operation Tolerance'] = tolerance!.toStringAsFixed(2);
    data['Operation Notes'] = convertNotes();
    data['Coolant'] = coolant;
    data['Tool Diameter'] = toolDiameter!.toStringAsFixed(2);
    data['Tool Corner Radius'] = cornerRadius!.toStringAsFixed(2);
    data['Tool Type'] = toolType;
    data['Operation Desc'] = operationDesc;
    data['Operation Tool Desc'] = operationToolDesc;
    data['Maximum Stepdown'] = maxStepdown!.toStringAsFixed(2);
    data['Maximum Stepover'] = maxStepover!.toStringAsFixed(2);
    data['Cutting Distance'] = cuttingDistance!.toStringAsFixed(2);
    data['Rapid Distance'] = rapidDistance!.toStringAsFixed(2);
    data['Operation Min Z'] = operationMinZ!.toStringAsFixed(2);
    data['Operation Max Z'] = operationMaxZ!.toStringAsFixed(2);
    data['Operation Time'] = operationTime;
    data['Operation Stock To Leave XY'] = operationStockToLeaveXY;
    data['Operation Stock To Leave Z'] = operationStockToLeaveZ;
    data['Operation Speed'] = operationSpeed!.toStringAsFixed(2);
    data['Operation Feed'] = operationFeed!.toStringAsFixed(2);
    return data;
  }

  convertNotes(){
    var text = notes.toString().runes.toList();
    return utf8.decode(text);
  }

}


class CiklusItem {
  String title;
  String value;
  bool isSelected;

  CiklusItem({required this.title, required this.value, this.isSelected = true});

}