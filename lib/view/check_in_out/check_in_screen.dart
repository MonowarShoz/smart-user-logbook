import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/location_provider.dart';
import 'package:technoart_monitoring/util/date_converter.dart';
import 'package:technoart_monitoring/util/dimensions.dart';
import '../../util/custom_themes.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  bool isSelected = true;
  bool iscsSelected = false;
  bool isCheckIN = false;

  TimeOfDay? _secpickedTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }

  getAddress() async {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    provider.getAddress(lat: provider.latitude, lang: provider.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, lp, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 242, 244, 246),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromARGB(255, 210, 222, 244),
          title: Text(
            'Hello UserName',
            style: robotoSlab.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 2),
          ),
        ),
        endDrawer: Drawer(),
        body: Container(
          width: Dimensions.fullWidth(context),
          height: Dimensions.fullHeight(context),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Right Now it is ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(217, 0, 0, 0),
                      ),
                    ),
                    Text(
                      '${DateConverter.formatDateIOS(DateTime.now().toString(), isTime: true)}',
                      textAlign: TextAlign.center,
                      style: robotoSlab.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),

                //margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'You are in ',
                        style: robotoSlab.copyWith(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: lp.placemarks.isNotEmpty
                          ? Row(
                              children: [
                                Icon(Icons.location_on),
                                Flexible(
                                  child: Text(
                                    '${lp.placemarks[0].name},${lp.placemarks[2].name},${lp.placemarks[3].name}',
                                    style: robotoSlab.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )
                          : Text(''),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'f',
                    //     style: josefinSans.copyWith(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Expanded(
              //   child: TextField(
              //     // minLines: 2,
              //     // maxLines: 50,
              //     decoration: InputDecoration(
              //       hintText: 'Please search here ',
              //       //contentPadding: EdgeInsets.all(8),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //       ),
              //       // border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              Container(
                width: double.infinity,
                height: 120,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '${DateConverter.formatDateIOS(DateTime.now().toString())}',
                        style: robotoSlab.copyWith(fontSize: 17),
                      ),
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                'CHECKED IN FOR',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              height: 24,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: isSelected ? Color.fromARGB(255, 152, 200, 239) : Color.fromARGB(255, 233, 239, 152),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  isSelected ? 'At work' : 'At site',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: robotoSlab.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Text(
                            //     _secpickedTime != null ? '${_secpickedTime!.hour}' : '',
                            //     style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                            //   ),
                            // ),
                          ],
                        ),
                        _secpickedTime != null
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: _secpickedTime!.hourOfPeriod.toString(),
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                    children: [],
                                  ),
                                  TextSpan(
                                    text: 'hrs ',
                                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: _secpickedTime!.minute.toString(),
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'mins',
                                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                ]),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '0',
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                    children: [],
                                  ),
                                  TextSpan(
                                    text: 'hrs ',
                                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: '0',
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'mins',
                                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                                  ),
                                ]),
                              ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //   child: Text(
                        //     _secpickedTime != null ? '${_secpickedTime!.hour}' : '',
                        //     style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                        //   ),
                        // ),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //       child: Text(
                    //         'Check Out Time',
                    //         style: TextStyle(fontSize: 17),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //         child: isCheckIN
                    //             ? Text(
                    //                 _secpickedTime != null ? _secpickedTime!.format(context) : '',
                    //                 style: TextStyle(color: Colors.red),
                    //               )
                    //             : Text(
                    //                 'In Office',
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextField(
                        minLines: 2,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Write a note(if any)',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        //mainAxisSize: MainAxisSize.max,

                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = true;
                                  iscsSelected = false;
                                });
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.black12 : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'At work',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = false;
                                  iscsSelected = true;
                                });
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: iscsSelected ? Colors.black12 : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'At Customer site',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
                        child: InkWell(
                          onTap: () {
                            selectsecDateTime();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.punch_clock),
                                ),
                                _secpickedTime != null
                                    ? Text('Traveling Time - ${_secpickedTime!.format(context)}')
                                    : Text(
                                        'Enter Traveling Time',
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isCheckIN ? Colors.red : Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isCheckIN = !isCheckIN;
                            });
                          },
                          child: isCheckIN ? Text('CHECK OUT') : Text('CHECK IN'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text('Powered By Techno Art'),
            ],
          ),
        ),
      );
    });
  }

  Future selectsecDateTime({fromd = false}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _secpickedTime = pickedTime;
      });
    }
  }
}
