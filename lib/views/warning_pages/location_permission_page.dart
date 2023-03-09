import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrobustest/cubit/bus_details_cubit.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<BusDetailsCubit>().notificationPerm();
          },
          child: const Text(
            "izin",
          ),
        ),
      ),
    );
  }
}
