import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technoart_monitoring/Provider/data_provider.dart';
import 'package:technoart_monitoring/model/user_add_model.dart';
import 'package:technoart_monitoring/util/code_util.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dp, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoNavigationBarBackButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 17),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // dp.userModel!.userImage == null
                    //     ? InkWell(
                    //         onTap: () async {
                    //           await dp.pickImage();
                    //         },
                    //         child: CircleAvatar(
                    //           radius: 50,
                    //           //b: Icon(Icons.person),
                    //         ),
                    //       )
                    //     :
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.indigo,
                          child: dp.userModel!.strImg == null
                              ? CircleAvatar(
                                  radius: 50,
                                  child: Icon(Icons.person),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(
                                    dp.convertFromBase64(CodeUtil.decompress(dp.userModel!.strImg!)),
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.indigo,
                            child: InkWell(
                              onTap: () async {
                                await dp.pickImage();
                              },
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      child: TextField(
                        controller: nameController,
                        obscureText: true,
                        decoration: InputDecoration(
                          //isDense: true,
                          // contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Edit User Name',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      child: TextField(
                        controller: designationController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Edit Designation',
                          hintStyle: TextStyle(color: Colors.black),
                          //isDense: true,
                          // contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(30),
                  child: Text('UPDATE'),
                  onPressed: () {
                    dp.updateUserInfo(
                        UserAddModel(
                          name: nameController.text,
                          designation: designationController.text,
                          userImage: dp.base64Img,
                        ),
                        dp.userModel!.id!);
                  })
            ],
          ),
        ),
      );
    });
  }
}
