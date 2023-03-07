import 'package:isar/isar.dart';
import 'package:metrobustest/model/bus_stops_model.dart';

class OpenDB {
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          BusStopModelSchema,
        ],
      );
    }
    return Future.value(Isar.getInstance());
  }
}
