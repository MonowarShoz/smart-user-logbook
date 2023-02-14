import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/location_provider.dart';
import 'package:technoart_monitoring/Provider/menu_provider.dart';
import 'package:technoart_monitoring/view/home_page.dart';
import 'package:technoart_monitoring/repository/di_container.dart' as di;
import 'package:technoart_monitoring/view/login/login_page.dart';

import 'Provider/data_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<MenuProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DataProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JosefinSans',
        primaryColor: Color.fromARGB(255, 252, 252, 252),
        brightness: Brightness.light,
        hintColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: const LoginScreen(),
    );
  }
}
