import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metrobustest/repository/isar_service.dart';
import 'package:metrobustest/repository/notification_repository.dart';
import '../model/bus_stops_model.dart';
import '../repository/calc_bus_stop_repository.dart';
import '../repository/location_repository.dart';
import 'bus_details_state.dart';

class BusDetailsCubit extends Cubit<BusDetailsState> {
  BusDetailsCubit({
    required LocationRepository locationRepository,
    required CalcRepository calcRepository,
    required IsarRepository isarRepository,
    required NotificationRepository notificationRepository,
  })  : _locationRepository = locationRepository,
        _calcRepository = calcRepository,
        _notificationRepository = notificationRepository,
        _isarRepository = isarRepository,
        super(
          const BusDetailsState(
              status: BusDetailsStateStatus.loading(),
              busStopList: null,
              alarmCount: null,
              alarmDistance: null,
              alarmID: null,
              currentStop: null,
              nextStop: null,
              nextStopDistance: null,
              speed: null,
              way: true),
        ) {
    getLocation();
  }

  final LocationRepository _locationRepository;
  final CalcRepository _calcRepository;
  final NotificationRepository _notificationRepository;
  final IsarRepository _isarRepository;

  Future<void> getLocation() async {
    Geolocator.getPositionStream(
            locationSettings: _locationRepository.locationSettings())
        .listen((Position position) async {
      await _calcRepository.updateBusStops(position);
      await confirmCalculatedData(position);
    });
  }

  Future<void> confirmCalculatedData(Position position) async {
    _isarRepository.listenBusStops().listen((event) async {
      emit(state.copyWith(
          status: const BusDetailsStateStatus.loaded(),
          currentStop: event[1],
          nextStop: state.way == true ? event[2] : event[0],
          nextStopDistance: await _calcRepository.nextStopDistance(
              state.way!, state.way == true ? event[2] : state.currentStop!),
          speed: (position.speed * 18) ~/ 5,
          alarmCount: await _calcRepository.alarmCount(
              state.alarmID, state.way ?? true),
          busStopList: _calcRepository.busStopModelList()));
    });
  }

  Future<void> changeWay(bool way) async {
    var next = await _calcRepository.nextBusStop(way);
    emit(state.copyWith(
        way: way,
        nextStop: next,
        nextStopDistance: await _calcRepository.nextStopDistance(way, next)));
  }

  Future<void> setAlarm(BusStopModel busStopModel) async {
    var position = await _locationRepository.getLocation();
    emit(state.copyWith(
        alarmID: busStopModel,
        alarmDistance:
            await _calcRepository.alarmDistance(position, busStopModel),
        alarmCount:
            await _calcRepository.alarmCount(busStopModel, state.way!)));
  }

  Future<void> notificationPerm() async {}
}
