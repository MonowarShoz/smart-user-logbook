import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/menu_provider.dart';
import 'package:technoart_monitoring/view/home_page.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => MenuProvider())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RobotoSlab',
        primaryColor: Color.fromARGB(255, 252, 252, 252),
        brightness: Brightness.light,
        hintColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: const HomePage(),
    );
  }
}
