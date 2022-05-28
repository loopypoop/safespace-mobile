import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/snack_message.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  late DateTime _initDate;
  bool changed = false;

  final _formKey = GlobalKey<FormState>();
  bool curPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;
  UserDetail user = UserDetail(
      id: 0,
      firstName: 'firstName',
      lastName: 'lastName',
      position: 'position',
      riskStatus: 'riskStatus',
      covidStatus: 'covidStatus',
      phoneNumber: 'phoneNumber',
      dateOfBirth: 1234,
      email: '',
      userId: 0);

  @override
  void initState() {
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
          key: _scaffoldKey,
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
                      buildTextField("First Name", "", _firstname, false),
                      buildTextField("Last Name", "", _lastname, false),
                      buildTextField("E-mail", "", _email, false),
                      buildTextField("Phone number", "", _phoneNumber, true),

                      // buildTextField("Location", "TLV, Israel", false, _dob),
                      Padding(
                        padding: EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          showCursor: true,
                          readOnly: true,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              // icon: Icon(Icons.calendar_today),
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: 'Date of birth',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                                lastDate: DateTime(2022));

                            if (pickedDate != null) {
                              _initDate = pickedDate;

                              String formattedDate = DateFormat('MMMM dd, yyyy')
                                  .format(pickedDate);

                              // _dob.text = pickedDate.toString();
                              setState(() {
                                _dob.text = formattedDate;
                                changed = true;
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
                              final body = {
                                "id": user.id,
                                "firstName": _firstname.text,
                                "email": _email.text,
                                "lastName": _lastname.text,
                                "position": user.position,
                                "riskStatus": user.riskStatus,
                                "covidStatus": user.covidStatus,
                                "phoneNumber": _phoneNumber.text,
                                "dateOfBirth": _initDate.millisecondsSinceEpoch,
                                "userId": user.userId,
                                "departmentId": user.departmentId
                              };

                              UserProvider().updateUser(body).then((value) {
                                _scaffoldKey.currentState
                                    ?.showSnackBar(SnackBar(
                                  backgroundColor:
                                      value == 'Personal information changed.'
                                          ? Colors.green
                                          : Colors.orange[400],
                                  duration: const Duration(seconds: 3),
                                  content: Text(value),
                                  action: SnackBarAction(
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                    label: '',
                                  ),
                                ));
                              });
                            },
                            color: changed ? primaryColor : Colors.grey,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
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
                      SizedBox(
                        height: 35,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Field can't be empty.";
                                    }
                                    // if (value.contains(RegExp(r'^\S*$/'))) {
                                    //   return "Entered password is not valid";
                                    // }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    changed = true;
                                  },
                                  obscureText: !curPasswordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 15),
                                      labelText: 'Current password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      suffixIcon: IconButton(
                                        icon: curPasswordVisible
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            curPasswordVisible =
                                                !curPasswordVisible;
                                          });
                                        },
                                      ),
                                      // hintText: placeholder,
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  controller: _currentPassword,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Field can't be empty.";
                                    }
                                    // if (value.contains(RegExp(r'^\S*$/'))) {
                                    //   return "Entered password is not valid";
                                    // }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    changed = true;
                                  },
                                  obscureText: !newPasswordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: 'New password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      suffixIcon: IconButton(
                                        icon: newPasswordVisible
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            newPasswordVisible =
                                                !newPasswordVisible;
                                          });
                                        },
                                      ),
                                      // hintText: placeholder,
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  controller: _newPassword,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Field can't be empty.";
                                    }
                                    // if (value.contains(RegExp(r'^\S*$/'))) {
                                    //   return "Entered password is not valid";
                                    // }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    changed = true;
                                  },
                                  obscureText: !confirmPasswordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: 'Confirm password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      suffixIcon: IconButton(
                                        icon: confirmPasswordVisible
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            confirmPasswordVisible =
                                                !confirmPasswordVisible;
                                          });
                                        },
                                      ),
                                      // hintText: placeholder,
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  controller: _confirmPassword,
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var changeRequest = {
                                  "userId": user.userId,
                                  "currentPassword": _currentPassword.text,
                                  "newPassword": _newPassword.text,
                                  "confirmationPassword": _confirmPassword.text
                                };
                                UserProvider()
                                    .changePassword(changeRequest)
                                    .then((value) {
                                  _scaffoldKey.currentState
                                      ?.showSnackBar(SnackBar(
                                    backgroundColor: value ==
                                            'Password changed successfully.'
                                        ? Colors.green
                                        : Colors.red,
                                    duration: const Duration(seconds: 3),
                                    content: Text(value),
                                    action: SnackBarAction(
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                      label: '',
                                    ),
                                  ));
                                });
                              }
                            },
                            color: changed ? primaryColor : Colors.grey,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      TextEditingController controller, isPhone) {
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
