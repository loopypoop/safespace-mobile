import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_auth/components/sidebar.dart';
import 'package:flutter_auth/model/UserDetail.dart';
import 'package:flutter_auth/provider/storage/storage_provider.dart';
import 'package:flutter_auth/provider/user_provider/user_provider.dart';

import 'package:flutter_auth/styles/colors.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  late DateTime _initDate;
  bool showPassword = false;
  bool changed = false;

  @override
  void initState() {
    UserDetail user;
    StorageProvider().getUserId().then((userId) {
      if (userId != null) {
        UserProvider().getUser(userId).then((value) {
          if (value == null) {
            StorageProvider().logOut(context);
          } else {
            user = value;
            DateTime dob =
                DateTime.fromMillisecondsSinceEpoch(user.dateOfBirth);

            _firstname.text = user.firstName;
            _lastname.text = user.lastName;
            _email.text = user.email;
            _phoneNumber.text = user.phoneNumber;
            _dob.text = DateFormat('MMMM dd, yyyy').format(dob);
            _initDate = dob;
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const SideBar(),
          appBar: AppBar(
            bottom: const TabBar(
              // labelStyle: TextStyle(fontSize: 12),
              tabs: [
                Tab(text: 'Personal info'),
                Tab(text: 'Change password'),
              ],
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            title: const Text('My profile'),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      // Center(
                      //   child: Stack(
                      //     children: [
                      //       Container(
                      //         width: 130,
                      //         height: 130,
                      //         decoration: BoxDecoration(
                      //             border: Border.all(
                      //                 width: 4,
                      //                 color: Theme.of(context).scaffoldBackgroundColor),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                   spreadRadius: 2,
                      //                   blurRadius: 10,
                      //                   color: Colors.black.withOpacity(0.1),
                      //                   offset: Offset(0, 10))
                      //             ],
                      //             shape: BoxShape.circle,
                      //             image: DecorationImage(
                      //                 fit: BoxFit.cover,
                      //                 image: NetworkImage(
                      //                   "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                      //                 ))),
                      //       ),
                      //       Positioned(
                      //           bottom: 0,
                      //           right: 0,
                      //           child: Container(
                      //             height: 40,
                      //             width: 40,
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               border: Border.all(
                      //                 width: 4,
                      //                 color: Theme.of(context).scaffoldBackgroundColor,
                      //               ),
                      //               color: Colors.green,
                      //             ),
                      //             child: Icon(
                      //               Icons.edit,
                      //               color: Colors.white,
                      //             ),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 35,
                      ),
                      buildTextField("Full Name", "Dor Alex", _firstname, false),
                      buildTextField("Full Name", "Dor Alex", _lastname, false),
                      buildTextField("E-mail", "alexd@gmail.com", _email, false),
                      buildTextField("Phone number", "********", _phoneNumber, true),

                      // buildTextField("Location", "TLV, Israel", false, _dob),
                      Padding(
                        padding: EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          onChanged: (text) {
                            changed = true;
                          },
                          showCursor: true,
                          readOnly: true,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              // icon: Icon(Icons.calendar_today),
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: 'Date of birth',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              // hintText: placeholder,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _initDate,
                                firstDate: DateTime(1930),
                                lastDate: DateTime(2022)
                            );

                            if (pickedDate != null) {
                              _initDate = pickedDate;
                              String formattedDate = DateFormat('MMMM dd, yyyy').format(pickedDate);

                              // _dob.text = pickedDate.toString();
                              setState(() {
                                _dob.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          // autovalidateMode: AutovalidateMode.always,
                          controller: _dob,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(

                            onPressed: () {
                              print(_initDate);
                            },
                            color: primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildTextField(String labelText, String placeholder, TextEditingController controller, isPhone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        onChanged: (text) {
          changed = true;
        },
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        controller: controller,
      ),
    );
  }
}
