import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/util/custom_themes.dart';
import 'package:technoart_monitoring/view/base_widgets/footer_widget.dart';

import '../../Provider/data_provider.dart';
import '../../Provider/location_provider.dart';
import '../../model/user_add_model.dart';
import '../../util/code_util.dart';
import '../../util/local_notif.dart';
import 'notifcation_message.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final nameController = TextEditingController();
  final desigController = TextEditingController();

  Future<void> setUpInteractMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['status'] == 'done') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NotifMessage(message: message),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    setUpInteractMessage();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
  }

  getUser() async {
    await Provider.of<DataProvider>(context, listen: false).getAllUserList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    return Consumer2<DataProvider, LocationProvider>(builder: (context, dp, lp, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromARGB(255, 210, 222, 244),
          title: Text(
            'Employee Screen',
            style: robotoSlab.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 2),
          ),
          actions: [
            CircleAvatar(
              backgroundImage: MemoryImage(dp.convertFromBase64(CodeUtil.decompress(dp.userModel!.strImg!))),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (p0, p1) {
            if (p1.maxWidth < 600) {
              return Container(
                height: p1.maxHeight,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        //shrinkWrap: true,
                        itemCount: dp.userList.length,
                        itemBuilder: (context, index) {
                          var item = dp.userList[index];
                          return ListTile(
                            onTap: () {
                              debugPrint("gg${item.firebaseDivToken!}");
                              dp.sendNotification(token: item.firebaseDivToken!, name: dp.userModel!.name);
                              // dp.openMap();
                            },
                            leading: item.strImg!.isNotEmpty
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      dp.convertFromBase64(CodeUtil.decompress(item.strImg!)),
                                    ),
                                    // child: Image.memory(

                                    //         fit: BoxFit.cover,
                                    //       )
                                    //     : Text('no'),
                                  )
                                : CircleAvatar(
                                    child: Center(
                                        child: Text(
                                      'no img',
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                            title: Text('${item.name}'),
                            subtitle: Text('${item.designation}'),
                          );
                        },
                      ),
                    ),
                    FooterWidget(),
                  ],
                ),
              );
            } else {
              return Container(
                color: Colors.red,
              );
            }
          },
        ),
      );
    });
  }
}
