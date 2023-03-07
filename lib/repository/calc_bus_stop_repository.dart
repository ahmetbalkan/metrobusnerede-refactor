import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:metrobustest/repository/isar_service.dart';
import 'package:metrobustest/repository/location_repository.dart';

import '../model/bus_stops_model.dart';

class CalcRepository {
  late BusStopModel busStopDetailsModel;
  final _isarRepository = IsarRepository();
  final _locationRepository = LocationRepository();

  Future<int> alarmCount(BusStopModel? alarmBusStop, bool way) async {
    var current = await _isarRepository.currentBusStop();
    if (current != null && alarmBusStop != null) {
      if (way == true) {
        final result = alarmBusStop.busstopid - current.busstopid;
        return result;
      } else {
        final result = current.busstopid - alarmBusStop.busstopid;
        print(result);
        return result;
      }
    }
    return 0;
  }

  Future<int> alarmDistance(Position? position, BusStopModel? alarm) async {
    if (position != null && alarm != null) {
      var result = await _calculateDistance(position.latitude,
          position.longitude, alarm.latitude, alarm.longitude);

      return result.toInt();
    }
    return 0;
  }

  Future<BusStopModel?> currentStop(Position location, bool way) async {
    var distanceList = await _returnDistance(location);
    double minDistance = await _findMin(distanceList);
    for (var i = 0; i < distanceList.length; i++) {
      if (distanceList[i] == minDistance) {
        if (minDistance < busStopModelList()[i].check / 2) {
          await _isarRepository.cleanDb();
          await _isarRepository.saveBusStop(busStopModelList()[i]);
          if (way == true) {
            await _isarRepository.saveBusStop(busStopModelList()[i + 1]);
          } else {
            await _isarRepository.saveBusStop(busStopModelList()[i - 1]);
          }

          //TODO başlangıç ve son durak hata veriyor.
          return busStopModelList()[i];
        }
      }
    }

    return null;
  }

  Future<void>? firstLocation(bool way) async {
    try {
      Position location = await _locationRepository.getLocation();
      var distanceList = await _returnDistance(location);
      double minDistance = await _findMin(distanceList);
      for (var i = 0; i < distanceList.length; i++) {
        if (distanceList[i] == minDistance) {
          await _isarRepository.cleanDb();
          await _isarRepository.saveBusStop(busStopModelList()[i]);
          if (way == true) {
            await _isarRepository.saveBusStop(busStopModelList()[i + 1]);
          } else {
            await _isarRepository.saveBusStop(busStopModelList()[i - 1]);
          }
        }
      }
    } catch (e) {
      return Future.error("Data Alınamıyor");
    }
  }

  Future<BusStopModel> nextStop(bool way, Position location) async {
    var nextStop = await _isarRepository.nextBusStop();
    if (nextStop.isNotEmpty) {
      return nextStop[0];
    } else {
      await firstLocation(way);
      var nextStop = await _isarRepository.nextBusStop();
      return nextStop[0];
    }
  }

  Future<int> nextStopDistance(Position position) async {
    var nextStop = await _isarRepository.nextBusStop();

    if (nextStop.isNotEmpty) {
      var distance = await _calculateDistance(position.latitude,
          position.longitude, nextStop[0].latitude, nextStop[0].longitude);

      return distance.toInt();
    }
    return 0;
  }

  Future<int> speed(Position location) async {
    double speed = (location.speed * 18) / 5;
    return speed.toInt();
  }

  Future<double> _findMin(List<double> distances) async {
    return distances.reduce(min);
  }

  List<BusStopModel> busStopModelList() {
    List<BusStopModel> busStopModelList = [];
    busStopModelList
        .add(BusStopModel(0, "B.DUZU SONDURAK", 41.022019, 28.625050, 168));
    busStopModelList.add(BusStopModel(1, "BEYKENT", 41.019562, 28.630895, 154));
    busStopModelList
        .add(BusStopModel(2, "CUMHURIYET MAH.", 41.015418, 28.641604, 158));
    busStopModelList
        .add(BusStopModel(3, "BEYLIKDUZU BEL.", 41.012331, 28.649756, 243));
    busStopModelList
        .add(BusStopModel(4, "BEYLIKDUZU", 41.009682, 28.656780, 157));
    busStopModelList
        .add(BusStopModel(5, "GUZELYURT", 41.006587, 28.665286, 144));
    busStopModelList
        .add(BusStopModel(6, "HAREMIDERE", 41.005986, 28.673169, 140));
    busStopModelList
        .add(BusStopModel(7, "HAREMIDERE SANAYI", 41.004454, 28.684950, 170));
    busStopModelList
        .add(BusStopModel(8, "SAADETDERE MAH.", 40.999741, 28.693115, 194));
    busStopModelList
        .add(BusStopModel(9, "MUSTAFA KEMAL PASA", 40.994989, 28.706205, 184));
    busStopModelList
        .add(BusStopModel(10, "CIHANGIR UNV. MAH.", 40.990726, 28.713612, 120));
    busStopModelList
        .add(BusStopModel(11, "AVCILAR", 40.983564, 28.725990, 180));
    busStopModelList
        .add(BusStopModel(12, "SUKRUBEY", 40.979978, 28.732035, 190));
    busStopModelList.add(
        BusStopModel(13, "IBB SOSYAL TESISLER", 40.977975, 28.745077, 142));
    busStopModelList
        .add(BusStopModel(14, "KUCUKCEKMECE", 40.986446, 28.769875, 125));
    busStopModelList
        .add(BusStopModel(15, "CENNET MAH.", 40.985348, 28.782700, 160));
    busStopModelList.add(BusStopModel(16, "FLORYA", 40.986746, 28.788792, 387));
    busStopModelList.add(BusStopModel(17, "BESYOL", 40.994289, 28.794891, 154));
    busStopModelList
        .add(BusStopModel(18, "SEFAKOY", 40.998590, 28.798545, 190));
    busStopModelList
        .add(BusStopModel(19, "YENIBOSNA", 40.992332, 28.834983, 256));
    busStopModelList
        .add(BusStopModel(20, "SIRINEVLER", 40.991722, 28.845987, 221));
    busStopModelList
        .add(BusStopModel(21, "BAHCELIEVLER", 40.995098, 28.863594, 132));
    busStopModelList
        .add(BusStopModel(22, "INCIRLI (BAKIRKOY)", 40.997814, 28.872305, 150));
    busStopModelList
        .add(BusStopModel(23, "ZEYTINBURNU", 41.003177, 28.890433, 220));
    busStopModelList.add(BusStopModel(24, "MERTER", 41.007745, 28.897581, 150));
    busStopModelList
        .add(BusStopModel(25, "CEVIZLIBAG", 41.016617, 28.911238, 332));
    busStopModelList
        .add(BusStopModel(26, "TOPKAPI", 41.020396, 28.917438, 150));
    busStopModelList
        .add(BusStopModel(27, "BAYRAMPASA", 41.024167, 28.921690, 217));
    busStopModelList
        .add(BusStopModel(28, "EDIRNEKAPI", 41.033703, 28.930116, 324));
    busStopModelList
        .add(BusStopModel(29, "AYVANSARAY / EYUP", 41.038698, 28.937556, 260));
    busStopModelList
        .add(BusStopModel(30, "HALICIOGLU", 41.048870, 28.946450, 250));
    busStopModelList
        .add(BusStopModel(31, "OKMEYDANI", 41.056287, 28.960850, 300));
    busStopModelList
        .add(BusStopModel(32, "DARULACEZE PERPA", 41.062485, 28.967853, 250));
    busStopModelList
        .add(BusStopModel(33, "OKMEYDANI HASTANE", 41.067379, 28.975725, 200));
    busStopModelList
        .add(BusStopModel(34, "CAGLAYAN", 41.067337, 28.980851, 180));
    busStopModelList
        .add(BusStopModel(35, "MECIDIYEKOY", 41.066869, 28.991690, 230));
    busStopModelList
        .add(BusStopModel(36, "ZINCIRLIKUYU", 41.066149, 29.013119, 156));
    busStopModelList
        .add(BusStopModel(37, "15 TEM. SEH. KOP.", 41.036593, 29.043351, 200));
    busStopModelList
        .add(BusStopModel(38, "BURHANIYE", 41.032020, 29.046939, 105));
    busStopModelList
        .add(BusStopModel(39, "ALTUNIZADE", 41.021904, 29.048345, 300));
    busStopModelList
        .add(BusStopModel(40, "ACIBADEM", 41.014534, 29.057279, 230));
    busStopModelList
        .add(BusStopModel(41, "UZUNCAYIR", 40.998859, 29.056540, 162));
    busStopModelList
        .add(BusStopModel(42, "FIKIRTEPE", 40.993912, 29.048362, 300));
    busStopModelList
        .add(BusStopModel(43, "S.CESME SONDURAK", 40.9923, 29.0359, 130));
    return busStopModelList;
  }

  Future<List<double>> _returnDistance(Position location) async {
    List<double> distanceList = [];

    try {
      for (var i = 0; i < busStopModelList().length; i++) {
        double distance = await _calculateDistance(
          location.latitude,
          location.longitude,
          busStopModelList()[i].latitude,
          busStopModelList()[i].longitude,
        );
        distanceList.add(distance);
      }
    } catch (e) {
      await Future.error("Hesaplanamadı");
    }

    return distanceList;
  }

  Future<double> _calculateDistance(lat1, lon1, lat2, lon2) async {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 1000 * 12742 * asin(sqrt(a));
  }
}
