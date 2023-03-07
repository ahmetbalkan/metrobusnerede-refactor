import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrobustest/repository/isar_service.dart';
import 'package:metrobustest/repository/notification_repository.dart';
import 'package:metrobustest/views/loader_page.dart';
import 'package:metrobustest/views/main_page.dart';
import 'package:metrobustest/views/warning_pages/notification_perm_page.dart';

import 'cubit/bus_details_cubit.dart';
import 'cubit/bus_details_state.dart';
import 'repository/calc_bus_stop_repository.dart';
import 'repository/location_repository.dart';
import 'views/warning_pages/fail_page.dart';
import 'views/warning_pages/location_disable_page.dart';
import 'views/warning_pages/network_disable_page.dart';
import 'views/warning_pages/location_permission_page.dart';

void main() {
  AwesomeNotifications().initialize(
      "resource://drawable/ic_launcher",
      [
        NotificationChannel(
          channelGroupKey: 'metrobus_nerede',
          channelKey: 'metrobus_notification',
          channelName: 'Metrobüs Nerede?',
          channelDescription: 'Durağa vardığınızda gösterilen bildirim.',
          enableVibration: true,
          playSound: true,
          defaultPrivacy: NotificationPrivacy.Public,
          importance: NotificationImportance.High,
          criticalAlerts: true,
          channelShowBadge: true,
          icon: "resource://drawable/ic_launcher",
          soundSource: "resource://raw/noti",
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'metrobus_nerede_group',
            channelGroupName: 'Metrobüs Nerede?')
      ],
      debug: true);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepository(),
        ),
        RepositoryProvider<CalcRepository>(
          create: (context) => CalcRepository(),
        ),
        RepositoryProvider<IsarRepository>(
          create: (context) => IsarRepository(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BusDetailsCubit>(
            create: (context) => BusDetailsCubit(
              calcRepository: context.read<CalcRepository>(),
              notificationRepository: context.read<NotificationRepository>(),
              locationRepository: context.read<LocationRepository>(),
              isarRepository: context.read<IsarRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<BusDetailsCubit, BusDetailsState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              builder: (context, child) {
                final scale =
                    MediaQuery.of(context).textScaleFactor.clamp(0.8, 0.9);
                return MediaQuery(
                    data:
                        MediaQuery.of(context).copyWith(textScaleFactor: scale),
                    child: child!);
              },
              title: 'Metrobüs Nerede?',
              theme: ThemeData(
                fontFamily: 'Armata',
              ),
              home: state.status.when(
                loading: () => const LoaderPage(),
                loaded: () => const MainPage(),
                failure: () => const FailPage(),
                permission: () => const LocationPermissionPage(),
                locationdisable: () => const LocationDisablePage(),
                networkdisable: () => const NetworkDisablePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
