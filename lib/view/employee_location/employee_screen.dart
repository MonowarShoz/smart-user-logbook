import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/util/custom_themes.dart';
import 'package:technoart_monitoring/view/base_widgets/footer_widget.dart';

import '../../Provider/data_provider.dart';
import '../../Provider/location_provider.dart';
import '../../model/user_add_model.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final nameController = TextEditingController();
  final desigController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).getAllUserList();
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
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<DataProvider>(builder: (context, ndp, child) {
                      return AlertDialog(
                        //contentPadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.zero,
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel),
                          )
                        ],
                        content: Container(
                          height: size.height / 2,
                          width: size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: desigController,
                                  decoration: InputDecoration(border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                child: Container(
                                  height: 40,
                                  decoration:
                                      BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 9),
                                        child: Text('Pick Image'),
                                      ),
                                      // selectedImg == null
                                      //     ? IconButton(
                                      //         onPressed: () async {
                                      //           await pickImage();
                                      //         },
                                      //         // onPressed: pickImage,
                                      //         icon: Icon(Icons.camera),
                                      //       )
                                      //     : ClipRRect(
                                      //         borderRadius: BorderRadius.circular(15),
                                      //         child: Image.file(
                                      //           selectedImg!,
                                      //           //dp.selectedImg!,
                                      //           cacheHeight: 40,
                                      //           cacheWidth: 40,
                                      //         ),
                                      //       ),
                                      ndp.selectedImg == null
                                          ? IconButton(
                                              onPressed: () async {
                                                await ndp.pickImage();
                                              },
                                              // onPressed: pickImage,
                                              icon: Icon(Icons.camera),
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Image.file(
                                                ndp.selectedImg!,
                                                cacheHeight: 40,
                                                cacheWidth: 40,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  ndp.addUser(UserAddModel(
                                    name: nameController.text,
                                    firebaseDivToken: '',
                                    latitude: ndp.latitude,
                                    longitude: ndp.longitude,
                                    timeOfCreate: DateTime.now().toString(),
                                    designation: desigController.text,
                                    userImage: ndp.base64Img,
                                  ));
                                  Navigator.pop(context);
                                },
                                child: Text('ADD'),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                );
              },
              icon: Icon(Icons.add),
            ),
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
                              dp.openMap();
                            },
                            leading: item.userImage != null
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      dp.convertFromBase64(item.userImage!),
                                    ),
                                    // child: Image.memory(

                                    //         fit: BoxFit.cover,
                                    //       )
                                    //     : Text('no'),
                                  )
                                : CircleAvatar(
                                    child: Center(child: Text('no img')),
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
