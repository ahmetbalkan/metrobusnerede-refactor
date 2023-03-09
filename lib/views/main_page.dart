import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:metrobustest/tools/extention.dart';
import 'package:metrobustest/views/way_page.dart';
import 'dart:math' as math;
import '../cubit/bus_details_cubit.dart';
import '../cubit/bus_details_state.dart';
import 'alarm_choise_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

double size = 100;
List<String> liste = [];

class _MainPageState extends State<MainPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BusDetailsCubit, BusDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.white),
                        left: BorderSide(width: 1, color: Colors.white),
                        top: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Center(
                        child: Text(
                          "Duraklar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.white),
                          left: BorderSide(width: 1, color: Colors.white),
                          top: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                      BoxConstraints constraints) =>
                                  ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.busStopList?.length,
                                itemExtent: constraints.maxHeight / 44,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: state.nextStop?.name == null
                                          ? null
                                          : (state.way == false
                                                      ? index - 1
                                                      : index + 1) ==
                                                  state.nextStop?.busstopid
                                              ? Colors.green
                                              : (state.way == false
                                                          ? index - 1
                                                          : index + 1) ==
                                                      43
                                                  ? null
                                                  : index ==
                                                          state.nextStop
                                                              ?.busstopid
                                                      ? Colors.orange.shade600
                                                      : null,
                                      border: const Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.white),
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.busStopList![index].name,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                padding: const EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/logo.png"),
                              )),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WayPage(),
                                    ));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.white),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.change_circle,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Yön Değiştir",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: state.currentStop == null
                                  ? Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: state.way == false
                                              ? Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(
                                                      math.pi),
                                                  child: Lottie.asset(
                                                    'assets/images/otobus.json',
                                                  ),
                                                )
                                              : Lottie.asset(
                                                  'assets/images/otobus.json',
                                                ),
                                        ),
                                        const Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                "Durağa gidiyorsunuz.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                state.currentStop?.name ?? "",
                                                textAlign: TextAlign.center,
                                                style: context.fontStyleLed(
                                                    Colors.green, 24),
                                              ),
                                            )),
                                        const Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "Durağındasınız.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    const Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            "Sonraki Durak",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Center(
                                          child: Text(
                                              state.nextStop?.name ??
                                                  "HESAPLANIYOR",
                                              textAlign: TextAlign.center,
                                              style: context.fontStyleLed(
                                                  Colors.white, 24)),
                                        )),
                                    const Spacer(),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Spacer(),
                                          const Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Kalan Mesafe",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      state.nextStopDistance
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          context.fontStyleLed(
                                                              Colors.white,
                                                              24)),
                                                  const Text(
                                                    " /m",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Spacer(),
                                          const Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Hız",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(state.speed.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          context.fontStyleLed(
                                                              Colors.white,
                                                              24)),
                                                  const Text(
                                                    " /km",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Alarm Göstergeleri",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Durak seç bölümünden bildirim almak istediğniiz durağı seçebilirsiniz.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        children: [
                                          const Spacer(),
                                          const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Seçtiğiniz Durak",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: Text(
                                                      state.alarmID?.name ??
                                                          "SECINIZ.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          context.fontStyleLed(
                                                              Colors.white,
                                                              18)),
                                                ),
                                              )),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AlarmChoisePage(),
                                                ));
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Lottie.asset(
                                                      'assets/images/tap.json',
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Durak \n Seç",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ))
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      const Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Seçtiğiniz Durağa Kalan Mesafe",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                    state.alarmDistance
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: context.fontStyleLed(
                                                        Colors.white, 24)),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "metre",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )),
                                      const Spacer()
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      const Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Inmek İçin Kalan Durak Sayısı",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    state.alarmCount!.isNegative
                                                        ? "TERS YON"
                                                        : state.alarmCount
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: context.fontStyleLed(
                                                        Colors.white, 22)),
                                              ),
                                            ],
                                          )),
                                      const Spacer()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
