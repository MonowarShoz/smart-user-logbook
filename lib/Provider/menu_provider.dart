import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technoart_monitoring/util/images.dart';
import 'package:technoart_monitoring/view/employee_location/employee_location_screen.dart';
import 'package:technoart_monitoring/view/ob_box_ui/groups_screen.dart';
import '../Models/menu_model.dart';
import '../repository/data_repo.dart';
import '../view/Employee_profile/emp_attendance_history.dart';
import '../view/check_in_out/check_in_screen.dart';
import '../view/employee_location/emp_location_list.dart';
import '../view/employee_location/employee_screen.dart';
import '../view/support/stepper_page.dart';

class MenuProvider with ChangeNotifier {
  final List<MenuModel> _menuList = [
    MenuModel(
      menuName: "Employee Location",
      iconData: Icons.location_on_outlined,
      icon: ImagesFile.perLocImg,
      routeName: EmployeeScreen(),
    ),
    MenuModel(
      menuName: "Employee Attendance",
      iconData: FontAwesomeIcons.user,
      icon: ImagesFile.empProfile,
      routeName: const EmpAttendanceHistory(),
    ),
    MenuModel(
      menuName: "Check IN/OUT",
      iconData: FontAwesomeIcons.check,
      icon: ImagesFile.nchkinout,
      routeName: CheckInScreen(),
    ),
    MenuModel(
      menuName: "Support",
      iconData: Icons.settings,
      icon: ImagesFile.suprtTicket,
      routeName: MyStepper(),
    ),
  ];

  List<MenuModel> get menuList => _menuList;
}
