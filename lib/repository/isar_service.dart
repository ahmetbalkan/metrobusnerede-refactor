import 'package:isar/isar.dart';
import 'package:metrobustest/model/bus_stops_model.dart';
import 'package:metrobustest/repository/opendb.dart';

class IsarRepository extends OpenDB {
  late Future<Isar> _db;
  IsarRepository() {
    _db = openDB();
  }

  Future<void> saveBusStop(BusStopModel busStop) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.busStopModels.put(busStop);
    });
  }

  Future<void> updateBusStop(BusStopModel busStop, int id) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      busStop.id = id;
      await isar.busStopModels.put(busStop);
    });
  }

  Future<void> cleanDb() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.busStopModels.clear());
  }

  Future<List<BusStopModel>> getBusStop() async {
    final isar = await _db;
    final result = await isar.busStopModels.where().findAll();
    return result;
  }

  Future<List<BusStopModel>> getBusStopByID(int id) async {
    final isar = await _db;
    final result = await isar.busStopModels.filter().idEqualTo(id).findAll();
    return result;
  }

  Future<BusStopModel> currentBusStop() async {
    final isar = await _db;
    final result = await isar.busStopModels.filter().idEqualTo(1).findAll();
    return result[0];
  }

  Stream<List<BusStopModel>> listenBusStops() async* {
    final isar = await _db;
    yield* isar.busStopModels.where().watch(fireImmediately: true);
  }
}
