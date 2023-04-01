import 'package:flutter/material.dart';
import 'package:technoart_monitoring/util/code_util.dart';
import 'package:technoart_monitoring/util/dimensions.dart';
import 'package:technoart_monitoring/view/Profile/edit_profile.dart';

import '../../Provider/data_provider.dart';
import '../../util/images.dart';
import '../login/login_page.dart';

class DrawerPage extends StatelessWidget {
  final DataProvider dp;
  const DrawerPage({
    super.key,
    required this.dp,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Color.fromARGB(255, 157, 194, 224),
              height: Dimensions.fullHeight(context) / 5,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      dp.userModel!.userImage != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: MemoryImage(dp.convertFromBase64(CodeUtil.decompress(dp.userModel!.strImg!))),
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              child: Image.asset(ImagesFile.suprtTicket, height: 40),
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${dp.userModel!.name!}'.toUpperCase(),
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${dp.userModel!.designation!}'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Text('Welcome'),

                  // CircleAvatar(
                  //   radius: 30,

                  //   child: dp.userModel!.userImage != null
                  //       ? Image.memory(dp.convertFromBase64(dp.userModel!.userImage!))
                  //       : Image.asset(ImagesFile.suprtTicket, height: 40),
                  // ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ));
              },
              leading: Icon(Icons.edit),
              title: Text('Profile'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
                dp.logout();
              },
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
