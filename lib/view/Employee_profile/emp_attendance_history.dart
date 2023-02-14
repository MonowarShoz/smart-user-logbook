import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/data_provider.dart';
import 'package:technoart_monitoring/util/custom_themes.dart';
import 'package:technoart_monitoring/view/base_widgets/footer_widget.dart';

import '../../util/images.dart';

class EmpAttendanceHistory extends StatefulWidget {
  const EmpAttendanceHistory({super.key});

  @override
  State<EmpAttendanceHistory> createState() => _EmpAttendanceHistoryState();
}

class _EmpAttendanceHistoryState extends State<EmpAttendanceHistory> {
  bool isSelected = false;
  bool iscsSelected = false;
  bool isLateSelected = false;
  bool isAllSelected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dp, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 253, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    BackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                    Center(
                      child: Text(
                        'Attendance History',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLateSelected = false;
                                  iscsSelected = false;
                                  isAllSelected = true;
                                  isSelected = false;
                                });
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // color: isAllSelected ? Colors.black12 : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        'All',
                                        style: robotoSlab.copyWith(
                                            fontSize: 18,
                                            color: isAllSelected ? Colors.red : Color.fromARGB(136, 0, 0, 0),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    isAllSelected
                                        ? Container(
                                            height: 4,
                                            color: Colors.red,
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLateSelected = true;
                                  iscsSelected = false;
                                  isAllSelected = false;
                                  isSelected = false;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'Late',
                                      style: robotoSlab.copyWith(
                                          fontSize: 18,
                                          color: isLateSelected ? Colors.red : Color.fromARGB(136, 0, 0, 0),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  isLateSelected
                                      ? Container(
                                          height: 4,
                                          color: Colors.red,
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLateSelected = false;
                                  iscsSelected = false;
                                  isAllSelected = false;
                                  isSelected = true;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'In Time',
                                      style: robotoSlab.copyWith(
                                          fontSize: 18,
                                          color: isSelected ? Colors.red : Color.fromARGB(136, 0, 0, 0),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  isSelected
                                      ? Container(
                                          height: 4,
                                          color: Colors.red,
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isAllSelected
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: dp.empattDList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                      child: Text(
                                        dp.empattDList[index].name!,
                                        style: robotoSlab.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(dp.empattDList[index].time!),
                                          Text(
                                            dp.empattDList[index].lateTime!,
                                            style: dp.empattDList[index].isLate
                                                ? robotoSlab.copyWith(
                                                    color: Colors.red,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                : robotoSlab.copyWith(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            ),
                          )
                        : isSelected
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: dp.empattDList.where((element) => element.isLate == false).length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                          child: Text(
                                            dp.empattDList.where((element) => element.isLate == false).toList()[index].name!,
                                            style: robotoSlab.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(dp.empattDList
                                                  .where((element) => element.isLate == false)
                                                  .toList()[index]
                                                  .time!),
                                              Text(
                                                dp.empattDList
                                                    .where((element) => element.isLate == false)
                                                    .toList()[index]
                                                    .lateTime!,
                                                style: dp.empattDList
                                                        .where((element) => element.isLate == false)
                                                        .toList()[index]
                                                        .isLate
                                                    ? TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      )
                                                    : TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: dp.empattDList.where((element) => element.isLate == true).length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                            child: Text(
                                              dp.empattDList.where((element) => element.isLate == true).toList()[index].name!,
                                              style: robotoSlab.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(dp.empattDList
                                                    .where((element) => element.isLate == true)
                                                    .toList()[index]
                                                    .time!),
                                                Text(
                                                  dp.empattDList
                                                      .where((element) => element.isLate == true)
                                                      .toList()[index]
                                                      .lateTime!,
                                                  style: dp.empattDList
                                                          .where((element) => element.isLate == true)
                                                          .toList()[index]
                                                          .isLate
                                                      ? TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        )
                                                      : TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ],
                ),
              ),
              FooterWidget(),
            ],
          ),
        ),
      );
    });
  }
}
