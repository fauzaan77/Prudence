import 'package:airship_carrier/components/common_widget.dart';
import 'package:airship_carrier/controllers/home_controller.dart';
import 'package:airship_carrier/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class PickupDateSelect extends StatelessWidget {

  int? sourceCityId;
  int? sourceAirportId;
  int? destinationCityId;
  int? destinationAirportId;

  PickupDateSelect({super.key,this.sourceAirportId,this.sourceCityId,this.destinationAirportId,this.destinationCityId});

DateTime? selectedDate;
DateTime? focusedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'selectPickupDate'.tr,
        leading: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              currentDay: DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                selectedDate = selectedDay;
                focusedDate = focusedDay;
                print("selectedDate $selectedDate");
                print("focusedDate $focusedDate");
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
              ),
              weekendDays: [DateTime.saturday, DateTime.sunday],
              formatAnimationCurve: Curves.easeIn,
              focusedDay: DateTime.now(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: ButtonPrimary(
                onPressed: () {
                  Get.to(() => HomeScreen());
                },
                title: 'continue'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
