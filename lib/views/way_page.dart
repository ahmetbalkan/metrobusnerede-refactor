import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import 'package:metrobustest/cubit/bus_details_cubit.dart';
import 'package:metrobustest/tools/extention.dart';

class WayPage extends StatelessWidget {
  const WayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text("Lütfen gitmek istediğiniz yönü seçiniz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  )),
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white,
          ),
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<BusDetailsCubit>().changeWay(false);
                      Navigator.pop(context);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: const [
                                Text(
                                  "Beylikdüzü ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Divider(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Yönüne gitmek için tıklayınız.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Lottie.asset(
                                'assets/images/arrow.json',
                                width: 150,
                                height: 200,
                              )),
                        ]),
                  ),
                ),
                const VerticalDivider(
                  thickness: 2,
                  color: Colors.white,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<BusDetailsCubit>().changeWay(true);
                      Navigator.pop(context);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: const [
                                Text(
                                  "Söğütlüçeşme ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Divider(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Yönüne gitmek için tıklayınız.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Lottie.asset(
                                  'assets/images/arrow.json',
                                  width: 150,
                                  height: 200,
                                ),
                              )),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}


/*

Column(
          children: [
            const Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Lütfen gitmek istediğiniz yönü seçiniz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Expanded(
              flex: 4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Beylikdüzü Yönü için tıklayınız.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Lottie.asset(
                            'assets/images/arrow.json',
                            width: 400,
                            height: 200,
                          ),
                        )),
                  ]),
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Söğütlüçeşme Yönü için tıklayınız.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            'assets/images/arrow.json',
                            width: 400,
                            height: 200,
                          )),
                    ]),
              ),
            ),
          ],
        ),
      */