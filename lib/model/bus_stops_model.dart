import 'package:isar/isar.dart';

part 'bus_stops_model.g.dart';

@collection
class BusStopModel {
  Id id = Isar.autoIncrement;
  final int busstopid;
  final String name;
  final double latitude;
  final double longitude;
  final int check;

  BusStopModel(
      this.busstopid, this.name, this.latitude, this.longitude, this.check);
}
