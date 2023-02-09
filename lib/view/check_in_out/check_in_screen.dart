import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:technoart_monitoring/util/date_converter.dart';
import 'package:technoart_monitoring/util/dimensions.dart';
import '../../util/custom_themes.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 210, 222, 244),
        title: Text(
          'Hello UserName',
          style: robotoSlab.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 2),
        ),
      ),
      drawer: Drawer(),
      body: Column(
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
            width: double.infinity,

            //margin: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              color: Color.fromARGB(255, 241, 242, 246),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'You are in',
                      style: robotoSlab.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Arambag Housing, Dhaka Bangladesh',
                      style: robotoSlab.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                    ),
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text('CHECK IN'),
            ),
          ),
        ],
      ),
    );
  }
}
