import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrobustest/cubit/bus_details_cubit.dart';
import 'package:metrobustest/cubit/bus_details_state.dart';
import 'package:metrobustest/tools/extention.dart';

import '../repository/notification_repository.dart';

class AlarmChoisePage extends StatelessWidget {
  const AlarmChoisePage({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationRepository notificationRepository = NotificationRepository();
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<BusDetailsCubit, BusDetailsState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Lütfen gitmek istediğiniz yönü seçiniz.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: state.busStopList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () async {
                          context
                              .read<BusDetailsCubit>()
                              .setAlarm(state.busStopList![index]);
                          Navigator.pop(context);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFe0f2f1)),
                            child: Center(
                                child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: context.backgroundColor,
                                fontSize: 23,
                              ),
                            )),
                          ),
                        ),
                        title: Text(
                          state.busStopList![index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 1,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
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