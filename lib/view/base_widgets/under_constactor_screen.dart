import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/dimensions.dart';
import 'footer_widget.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Dimensions.fullHeight(context),
        width: Dimensions.fullWidth(context),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.circleArrowLeft,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(244, 242, 235, 235),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white38.withOpacity(0.5),
                                spreadRadius: -5,
                                offset: Offset(-5, -5),
                                blurRadius: 30,
                              ),
                              BoxShadow(
                                color: Colors.white38.withOpacity(0.5),
                                spreadRadius: -5,
                                offset: Offset(7, 2),
                                blurRadius: 30,
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            'THIS PAGE IS UNDER CONSTRUCTION',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color.fromARGB(255, 241, 35, 35), fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 19.0),
                    child: Text(
                      'Thanks For using  Mobile APP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.indigo,
                      ),
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
  }
}
