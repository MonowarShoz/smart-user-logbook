import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/location_provider.dart';
import 'package:technoart_monitoring/Provider/menu_provider.dart';
import 'package:technoart_monitoring/util/dimensions.dart';
import 'package:technoart_monitoring/util/images.dart';
import 'package:technoart_monitoring/view/base_widgets/under_constactor_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../util/custom_themes.dart';
import 'base_widgets/footer_widget.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  getLoc() async {
    await Provider.of<LocationProvider>(context, listen: false).getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(builder: (context, mp, child) {
      return Scaffold(
        key: _scaffoldKey,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(70),
        //   child: AppBar(
        //     iconTheme: IconThemeData(color: Colors.white),
        //     title: Center(
        //       child: Text(
        //         'TechnoArt Smart Monitoring',
        //         style: robotoSlab.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
        //       ),
        //     ),
        //     //title: Image.asset(Images.prBranding),
        //     elevation: 0.0,
        //     backgroundColor: Colors.transparent,

        //     // shape: RoundedRectangleBorder(
        //     //   borderRadius: BorderRadius.vertical(
        //     //     bottom: Radius.circular(40),
        //     //   ),
        //     // ),
        //     //backgroundColor: const Color.fromARGB(255, 128, 179, 70),
        //     // flexibleSpace: ClipPath(
        //     //   clipper: CustomShape(),
        //     //   child: Container(
        //     //     height: 250,
        //     //     width: MediaQuery.of(context).size.width,
        //     //     color: Colors.red,
        //     //     // child: Text('Proshika PFMS'),
        //     //   ),
        //     // ),
        //     flexibleSpace: Container(
        //       decoration: const BoxDecoration(
        //         borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(40),
        //           bottomRight: Radius.circular(40),
        //         ),
        //         gradient: LinearGradient(colors: [
        //           Colors.deepOrange,
        //           Colors.deepOrange,
        //         ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        //       ),
        //     ),
        //     // leading: Padding(
        //     //   padding: const EdgeInsets.all(8.0),
        //     //   child: Icon(Icons.menu),
        //     // ),
        //   ),
        // ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Column(
                children: [
                  Text('Welcome'),
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(ImagesFile.suprtTicket, height: 40),
                  ),
                  Text('User001'),
                  Text('ID: 10323231'),
                ],
              )),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                elevation: 2,
                child: Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 245, 249, 255),
                      Color.fromARGB(255, 220, 232, 254),
                      // Color.fromARGB(255, 3, 48, 184),
                      // Color.fromARGB(255, 3, 48, 184),
                      // Color.fromARGB(255, 184, 46, 3),
                      // Color.fromARGB(255, 176, 48, 9),
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.indigo,
                        ),
                      ),
                      RichText(
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
                      // Text(

                      //   style: robotoSlab.copyWith(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 20,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.fullHeight(context) / 5,
                child: GridView.builder(
                  itemCount: mp.menuList.length,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 110,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => mp.menuList[index].routeName ?? UnderConstructionScreen(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 220, 232, 254),
                          // color: Color.fromARGB(255, 249, 232, 206),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              child: Image.asset(
                                mp.menuList[index].icon!,
                                //fit: BoxFit.cover,
                                // height: 46,
                              ),
                            ),
                            Text(
                              mp.menuList[index].menuName!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                              style: josefinSans.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,

                //margin: const EdgeInsets.symmetric(vertical: 8),
                child: Card(
                  color: Color.fromARGB(255, 188, 203, 229),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Important Notice',
                          style: josefinSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
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
              Container(
                width: double.infinity,

                //margin: const EdgeInsets.symmetric(vertical: 8),
                child: Card(
                  color: Color.fromARGB(255, 210, 222, 244),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Your Status',
                          style: josefinSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(color: Color.fromARGB(255, 210, 222, 244), borderRadius: BorderRadius.circular(10)),
                  height: Dimensions.fullHeight(context) / 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            child: Text(
                              'Your Current Attendance Status',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                'IN',
                                style:
                                    TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 56, 147, 59)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Consumer<LocationProvider>(builder: (context, lp, child) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    'Your Current Location',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    'Latitude',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    '${lp.latitude}',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    'Longitude',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    '${lp.longitude}',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // CarouselSlider.builder(
              //     itemCount: 2,
              //     itemBuilder: (context, index, realIndex) {
              //       return Container(
              //         width: double.infinity,
              //         height: 70,
              //         //margin: const EdgeInsets.symmetric(vertical: 8),
              //         child: Card(
              //           color: Color.fromARGB(255, 52, 97, 174),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text(
              //                   'Important Notice',
              //                   style: josefinSans.copyWith(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //     options: CarouselOptions(
              //       height: 100,
              //       aspectRatio: 2 / 3,
              //       viewportFraction: 0.8,
              //       initialPage: 0,
              //       enableInfiniteScroll: true,
              //       reverse: false,
              //       autoPlay: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //       autoPlayAnimationDuration: Duration(milliseconds: 800),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       enlargeCenterPage: true,
              //       enlargeFactor: 0.8,
              //       scrollDirection: Axis.horizontal,
              //     )),
              // Container(
              //   width: double.infinity,
              //   height: 70,
              //   margin: const EdgeInsets.symmetric(vertical: 8),
              //   child: Card(
              //     color: Color.fromARGB(255, 52, 97, 174),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'Important Notice',
              //             style: josefinSans.copyWith(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 8),
              //   height: 60,
              //   width: double.infinity,
              //   decoration: BoxDecoration(color: Color.fromARGB(255, 231, 244, 250), borderRadius: BorderRadius.circular(20)),
              //   child: Text('Important Notice'),
              // ),
              Expanded(child: SizedBox()),
              FooterWidget()
            ],
          ),
        ),
      );
    });
  }
}
