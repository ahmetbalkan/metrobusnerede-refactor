import 'package:flutter/material.dart';
import 'package:metrobustest/model/bus_stops_model.dart';
import 'package:metrobustest/tools/extention.dart';

import '../repository/isar_service.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _isarRepository = IsarRepository();

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Konumunuz alınıyor.\n Lütfen bekleyiniz.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
