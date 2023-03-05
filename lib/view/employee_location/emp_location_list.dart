import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/location_provider.dart';
import 'package:technoart_monitoring/view/employee_location/employee_location_screen.dart';

import '../../Provider/data_provider.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  var myFutureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFutureData = Provider.of<DataProvider>(context, listen: false).getAllUserList();
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    // Provider.of<DataProvider>(context, listen: false).userList.clear();
    if (!mounted) return;
    await Provider.of<DataProvider>(context, listen: false).getAllUserList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DataProvider, LocationProvider>(builder: (context, dp, lp, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Employee '),
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: myFutureData,
              builder: (context, snapshot) => ListView.builder(
                itemCount: dp.userList.length,
                itemBuilder: (context, index) {
                  var item = dp.userList[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 216, 231, 233),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text('Name :', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                              Text(
                                '${item.name!.toUpperCase()}',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Text(
                        //         'Name:',
                        //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //     Text(
                        //       item.name!,
                        //       style: TextStyle(fontSize: 17),
                        //     ),
                        //   ],
                        // ),
                        // // Padding(
                        // //   padding: const EdgeInsets.all(8.0),
                        // //   child: Row(
                        // //     children: [
                        // //       Text('firebase Token:'),
                        // //       Flexible(child: Text(item.firebaseDivToken!)),
                        // //     ],
                        // //   ),
                        // // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Latitude :'),
                              Text(item.latitude!.toString()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Longitude :'),
                              Text(item.longitude!.toString()),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       Text('Time :'),
                        //       item.dateTime != null
                        //           ? Text(
                        //               '${item.dateTime.toString() != "string" ? DateConverter.formatDateIOS(item.dateTime!, isTimeDate: true) : ""}')
                        //           : Text(''),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  lp.addpoint(
                                    item.latitude!.toDouble(),
                                    item.longitude!.toDouble(),
                                  );
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EmployeeLocationScreen(),
                                  ));
                                  //dp.startTimer();
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => LocationTestPage(
                                  //     //imagePath: image.path,
                                  //   ),
                                  // ));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => CheckingIndvPage(id: item.id!),
                                  // ));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => MapScreen(),
                                  // ));
                                  //dp.openMap(item.latitude!.toDouble(), item.longitude!.toDouble());
                                },
                                icon: Icon(Icons.map),
                                label: Text('Check in Map'),
                              ),
                            ),
                          ],
                        )
                        // Text(item.longitude!.toString()),
                      ],
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      );
    });
  }
}
