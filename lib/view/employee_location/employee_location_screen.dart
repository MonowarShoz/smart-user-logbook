import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmployeeLocationScreen extends StatefulWidget {
  const EmployeeLocationScreen({super.key});

  @override
  State<EmployeeLocationScreen> createState() => _EmployeeLocationScreenState();
}

class _EmployeeLocationScreenState extends State<EmployeeLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Location'),
      ),
    );
  }
}
