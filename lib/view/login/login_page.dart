import 'package:flutter/material.dart';
import 'package:technoart_monitoring/util/dimensions.dart';
import 'package:technoart_monitoring/view/home_page.dart';

import '../../util/custom_themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 232, 254),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: 'Techno',
                style: josefinSans.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 21, 122),
                  // color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Art',
                    style: josefinSans.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 23, 6),
                    ),
                  ),
                  TextSpan(
                    text: ' Employee LogBook',
                    style: josefinSans.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'UserName',
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Password',
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: Dimensions.fullWidth(context) / 2,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 133, 230),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('LOGIN'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
