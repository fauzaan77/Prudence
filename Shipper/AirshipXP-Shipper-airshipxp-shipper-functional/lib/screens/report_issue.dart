import 'package:airshipxp_shipper/components/common_styles.dart';
import 'package:airshipxp_shipper/components/common_widget.dart';
import 'package:airshipxp_shipper/controllers/support_controller.dart';
import 'package:airshipxp_shipper/screens/raise_issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final SupportController supportController = Get.put(SupportController());

  @override
  void initState() {
    print(DateTime.now());
    supportController.scrollController
        .addListener(supportController.scrollListener);
    supportController.myIssues.value = [];
    supportController.getIssues(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Report Issue',
        leading: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.to(() => RaiseIssue(), arguments: 0);
          print("result : $result");
          if (result != null) {
            if (result == 'issueRaised') {
              supportController.myIssues.value = [];
              supportController.getIssues(0);
            }
          }
        },
        shape: CircleBorder(),
        backgroundColor: black,
        child: Icon(
          (Icons.add),
          size: 35,
          color: white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Obx(
        () => supportController.loadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : supportController.myIssues.isNotEmpty
                ? ListView.builder(
                    controller: supportController.scrollController,
                    itemCount: supportController.myIssues.length,
                    itemBuilder: (context, index) {
                      return IssueContainer(
                          ticket: supportController.myIssues[index].ticket,
                          issueTitle:
                              supportController.myIssues[index].issuetitle,
                          issueDescription:
                              supportController.myIssues[index].issuedesc,
                          issueDate:
                              supportController.myIssues[index].issuedate,
                          issueStatus:
                              supportController.myIssues[index].issuestatus,
                          adminResponse:
                              supportController.myIssues[index].response ?? "");
                    })
                : Center(
                    child: Text(
                      "noIssuesFound".tr,
                      style: kText16w600,
                    ),
                  ),
      ),
    );
  }
}

// ignore: must_be_immutable
class IssueContainer extends StatelessWidget {
  IssueContainer(
      {super.key,
      required this.ticket,
      required this.issueTitle,
      required this.issueDate,
      required this.issueStatus,
      required this.issueDescription,
      this.adminResponse});

  String ticket;
  String issueTitle;
  String issueStatus;
  String? adminResponse;
  String issueDescription;
  String issueDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: greyOp2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'issue'.tr,
                          style: kText14w600.copyWith(color: grey),
                        ),
                        Text(
                          issueTitle,
                          style: kText18w600,
                        )
                      ]),
                  Seperator(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'issueDescription'.tr,
                          style: kText14w600.copyWith(color: grey),
                        ),
                        Text(
                          issueDescription,
                          style: kText18w600,
                        )
                      ]),
                  Seperator(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'issueDate'.tr,
                          style: kText14w600.copyWith(color: grey),
                        ),
                        Text(
                          '${DateFormat.jm().format(DateTime.parse(issueDate).toLocal())}, ${DateFormat('EEE, MMM d').format(DateTime.parse(issueDate).toLocal())}',
                          style: kText18w600,
                        )
                      ]),
                  Seperator(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'status'.tr,
                          style: kText14w600.copyWith(color: grey),
                        ),
                        Text(
                          issueStatus,
                          style: kText18w600,
                        )
                      ]),
                  if (adminResponse != "") Seperator(),
                  if (adminResponse != "")
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'admin'.tr,
                            style: kText14w600.copyWith(color: grey),
                          ),
                          Text(
                            adminResponse ?? '',
                            style: kText18w600.copyWith(color: Colors.green),
                          )
                        ])
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(30),
                  ),
                ),
                height: 80,
                width: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'issue'.tr,
                        style: kText14w600.copyWith(color: white),
                      ),
                      Text(
                        ticket,
                        style: kText18w600.copyWith(color: white),
                      )
                    ]),
              ),
            )
          ]),
    );
  }
}
