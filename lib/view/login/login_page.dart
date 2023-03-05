import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/location_provider.dart';
import 'package:technoart_monitoring/util/dimensions.dart';
import 'package:technoart_monitoring/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Provider/data_provider.dart';
import '../../model/update_token_model.dart';
import '../../util/custom_themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? _token;
  getLoc() async {
    await Provider.of<LocationProvider>(context, listen: false).getLoc();
  }

  updateTokenLatLong(
    String token,
    String userID,
  ) {
    final locProvider = Provider.of<LocationProvider>(context, listen: false);

    Provider.of<DataProvider>(context, listen: false).updateTokenLatLong(
        UpdateTokenModel(
          firebaseDivToken: token,
          latitude: locProvider.latitude,
          longitude: locProvider.latitude,
          dateTime: DateTime.now().toString(),
        ),
        userID);
  }

  getAndStoreToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    _token = token;
    debugPrint('fb TOken $_token');
    // if (!mounted) return;
    // await updateTokenLatLong(token!, Provider.of<DataProvider>(context, listen: false).userModel!.id!);
    // FirebaseMessaging.instance.onTokenRefresh.listen(
    //   (token) {
    //     updateTokenLatLong(token, Provider.of<DataProvider>(context, listen: false).userModel!.id!);
    //   },
    // );

    // setState(() {
    //   _token = token;
    // });
  }

  login(DataProvider dp) async {
    if (userNameController.text.isEmpty) {
      debugPrint('user name must not be empty');
    } else {
      //if (!mounted) return;
      dp.loginUser(user: userNameController.text).then((value) async {
        if (value.isSuccess) {
          final SharedPreferences pref = await prefs;

          await getAndStoreToken();
          await updateTokenLatLong(_token!, dp.userModel!.id!);
          // if(dp.userModel!.firebaseDivToken! == _token){

          // }
          pref.setString(
            'userID',
            dp.userModel!.id!,
          );
          pref.setString(
            'firebaseToken',
            _token!,
          );

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(
                  // latitude: latitude!,
                  // longitude: longitude!,
                  ),
            ),
          );

          debugPrint('Local store user iD ${pref.getString('userID')}');
        } else {
          debugPrint('Failed');
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dp, child) {
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
                controller: userNameController,
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
                  onPressed: () async {
                    login(dp);
                    final service = FlutterBackgroundService();
                    // var isRunning = await service.isRunning();
                    // if (isRunning) {
                    //   service.invoke("stopService");
                    // } else {
                    service.startService();
                    // }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 16, 133, 230),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
