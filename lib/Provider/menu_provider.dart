import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technoart_monitoring/util/images.dart';
import 'package:technoart_monitoring/view/employee_location/employee_location_screen.dart';
import '../Models/menu_model.dart';

class MenuProvider with ChangeNotifier {
  final List<MenuModel> _menuList = [
    MenuModel(
      menuName: "Employee Location",
      iconData: Icons.location_on_outlined,
      icon: ImagesFile.perLocImg,
      routeName: EmployeeLocationScreen(),
    ),
    MenuModel(
      menuName: "Employee Profile",
      iconData: FontAwesomeIcons.user,
      icon: ImagesFile.profileImg,
    ),
    MenuModel(
      menuName: "Check IN/OUT",
      iconData: FontAwesomeIcons.check,
      icon: ImagesFile.nchkinout,
    ),
    MenuModel(
      menuName: "Support",
      iconData: Icons.settings,
      icon: ImagesFile.suprtTicket,
    ),
  ];

  List<MenuModel> get menuList => _menuList;
}
