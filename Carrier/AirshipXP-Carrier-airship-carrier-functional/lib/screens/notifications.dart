import 'package:airship_carrier/bloc/home/home_bloc.dart';
import 'package:airship_carrier/bloc/home/home_event.dart';
import 'package:airship_carrier/bloc/home/home_state.dart';
import 'package:airship_carrier/bloc/notification/notification_bloc.dart';
import 'package:airship_carrier/bloc/notification/notification_event.dart';
import 'package:airship_carrier/bloc/notification/notification_state.dart';
import 'package:airship_carrier/components/common_styles.dart';
import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/components/drawer.dart';
import 'package:airship_carrier/models/CarrierBookingsModel.dart';
import 'package:airship_carrier/models/NotificationModel.dart';
import 'package:airship_carrier/screens/package_details.dart';
import 'package:airship_carrier/screens/source_city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  GlobalKey<ScaffoldState> _key = GlobalKey();

  NotificationBloc _notificationBloc = NotificationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
        appBar: CustomAppBar(
          leading: true,
          titleText: 'Notification'.tr,
        ),
      body: SafeArea(
        child: BlocProvider(
            create: (_) => _notificationBloc..add(NotificationLoadEvent()),
            child: BlocListener<NotificationBloc, NotificationState>(
                listener: (BuildContext listenerCtx, NotificationState state) {
                  if (state is NotificationErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                      ),
                    );
                  }
                }, child: BlocBuilder<NotificationBloc, NotificationState>(builder: (blocCtx, state) {
              return SafeArea(
                child: Stack(
                  children: [
                    if (state is NotificationLoadedState)
                      _showNotifications(state.notificationData?.notifications),
                    if (state is NotificationLoadingState)
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              );
            }))),
      ),
    );
  }

  Widget _buildOfflineHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/home.png',
            height: 200,
          ),
          Text(
            'greatChance'.tr,
            style: kText16w500.copyWith(color: white),
          ),
          SizedBox(
            height: Get.height * 0.2,
          ),
          CustomBox(
            padding: EdgeInsets.all(8),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PickupCityScreen()));
            },
            alignment: Alignment.center,
            link: true,
            child: Text(
              'enterOrEdit'.tr,
              textAlign: TextAlign.center,
              style: kText18w600,
            ),
          )
        ],
      ),
    );
  }

  Widget _showNotifications(List<Notifications>? listNoti) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              itemBuilder: (context, index) {
                return CustomBox(
                  borderColor: Colors.black,
                    padding: EdgeInsets.all(15),
                    link: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listNoti?[index].notificationtitle??"",
                          style: kText18w600,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(listNoti?[index].notificationbody??"",
                          style: kText14w400.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(listNoti?[index].createdondate??"",
                          style: kText12w300,
                        ),
                      ],
                    ));
              },
              separatorBuilder: (context, index) => const Seperator(),
              itemCount: listNoti?.length ?? 0),
        ),
        const Seperator(),
        Text(
          'packageAvailableOnRoute'.tr,
          style: kText18w700.copyWith(color: white),
        ),
      ],
    );
  }
}
