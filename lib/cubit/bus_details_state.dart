import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/bus_stops_model.dart';

part 'bus_details_state.freezed.dart';

@freezed
class BusDetailsState with _$BusDetailsState {
  const factory BusDetailsState({
    required BusDetailsStateStatus status,
    required bool? way,
    required BusStopModel? currentStop,
    required BusStopModel? nextStop,
    required int? nextStopDistance,
    required int? speed,
    required BusStopModel? alarmID,
    required int? alarmDistance,
    required int? alarmCount,
    required List<BusStopModel>? busStopList,
  }) = _BusDetailsState;
  const BusDetailsState._();
}

@freezed
class BusDetailsStateStatus with _$BusDetailsStateStatus {
  const factory BusDetailsStateStatus.loading() = _loading;
  const factory BusDetailsStateStatus.loaded() = _loaded;
  const factory BusDetailsStateStatus.failure() = _failure;
  const factory BusDetailsStateStatus.permission() = _permission;
  const factory BusDetailsStateStatus.locationdisable() = _locationdisable;
  const factory BusDetailsStateStatus.networkdisable() = _networkdisable;
}
