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
    calculateDetails();
  }

  final LocationRepository _locationRepository;
  final CalcRepository _calcRepository;
  final NotificationRepository _notificationRepository;

  Future<void> calculateDetails() async {
    try {
      var permission = await _locationRepository.getPermission();

      if (!permission) {
        emit(state.copyWith(status: const BusDetailsStateStatus.permission()));
      } else {
        Geolocator.getPositionStream(
                locationSettings: await _locationRepository.locationSettings())
            .listen((Position position) async {
          var serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            emit(state.copyWith(
                status: const BusDetailsStateStatus.permission()));
          } else {
            if (!await _notificationRepository.checkPermission()) {
              emit(state.copyWith(
                  status: const BusDetailsStateStatus.permission()));
            } else {
              if (state.alarmID != null &&
                  state.currentStop?.busstopid == state.alarmID?.busstopid) {
                await _notificationRepository
                    .showNotification(state.alarmID!.name);
                emit(state.copyWith(alarmID: null));
              }
              emit(
                state.copyWith(
                  busStopList: _calcRepository.busStopModelList(),
                  status: const BusDetailsStateStatus.loaded(),
                  alarmCount: await _calcRepository.alarmCount(
                      state.alarmID, state.way ?? true),
                  alarmDistance: await _calcRepository.alarmDistance(
                      position, state.alarmID),
                  currentStop:
                      await _calcRepository.currentStop(position, state.way!),
                  //TODO tüm null bırakılabilirlere null kontrol çek.
                  nextStop:
                      await _calcRepository.nextStop(state.way!, position),
                  nextStopDistance:
                      await _calcRepository.nextStopDistance(position),
                  speed: await _calcRepository.speed(position),
                ),
              );
            }
          }
        });
      }
    } catch (_) {
      emit(state.copyWith(status: const BusDetailsStateStatus.failure()));
    }
  }

  Future<void> firstLocation() async {
    try {
      var permission = await _locationRepository.getPermission();

      if (!permission) {
        emit(state.copyWith(status: const BusDetailsStateStatus.permission()));
      } else {
        await _calcRepository.firstLocation(state.way!);
        //TODO buraya tüm dataları tekrar çekerek ekranı güncelleyebilirim . live locationda yaptığım gibi.
      }
    } catch (_) {
      emit(state.copyWith(status: const BusDetailsStateStatus.failure()));
    }
  }

  Future<void> changeWay(bool way) async {
    emit(state.copyWith(way: way, nextStop: null));
    await _calcRepository.firstLocation(way);
  }

  Future<void> setAlarm(BusStopModel busStopModel) async {
    emit(state.copyWith(alarmID: busStopModel));
  }
}