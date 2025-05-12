import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/screens/common/package_weight.dart';
import 'package:airshipxp_shipper/screens/common/request_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class PickupDateSelect extends StatefulWidget {
  const PickupDateSelect({super.key});

  @override
  State<PickupDateSelect> createState() => _PickupDateSelectState();
}

class _PickupDateSelectState extends State<PickupDateSelect> {
  var selected = DateTime.now().obs;
  var focused = DateTime.now().obs;

  var calendarFormat = CalendarFormat.month.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'selectPickupDate'.tr,
        leading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              currentDay: selected.value,
              onDaySelected: (selectedDay, focusedDay) {
                // print(selectedDay);
                selected.value = selectedDay;
                focused.value = focusedDay;
              },
              formatAnimationCurve: Curves.easeIn,
              calendarFormat: calendarFormat.value,
              onFormatChanged: (format) {
                calendarFormat.value = format;
              },
              focusedDay: focused.value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: ButtonPrimary(
              onPressed: () {
                Get.to(() => RequestSummary());
              },
              title: 'continue'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
