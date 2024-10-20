class DateHelper {
  final String fullDate = DateTime.now().toIso8601String();
  late String datum;
  late String time;

  String get getDay {
    var elems = fullDate.split("T");
    // Datum 2021-01-16
    datum = elems[0].trim();
    return datum;

  }

  String get getDatum {
    var elems = fullDate.split("T");
    // Datum 2021-01-16
    //datum = elems[0].trim();
    //Datum 2021-01-16 10:53:14
    datum = elems[0].trim() +" "+ getTime;

    return datum;
  }

  String get getTime {
    var elems = fullDate.split("T");
    var times = elems[1].trim().split(".");
    // Time 10:53:14
    time = times[0].trim();
    return time;
  }
}