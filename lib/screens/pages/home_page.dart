import 'package:flutter/material.dart';
import 'package:flutter_auth/components/CardWidget.dart';
import 'package:flutter_auth/components/StatsGrid.dart';
import 'package:flutter_auth/components/sidebar.dart';
import 'package:flutter_auth/styles/colors.dart';

import '../../model/Button.dart';
import '../../shared/custom_icons.dart';

class HomePage extends StatelessWidget {
  List<Button> icons = [
    Button(name: "Add", iconData: CustomIcons.add_box),
    Button(
      name: "Archive",
      iconData: CustomIcons.archive,
    ),
    Button(
      name: "Attach File",
      iconData: CustomIcons.attach_file,
    ),
    Button(
      name: "Back",
      iconData: CustomIcons.backspace,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          title: const Text("SafeSpace"),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                "Welcome, John!",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuickSand',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 20, bottom: 10),
              child: const Text(
                "Here is your Health Indicators for the day",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuickSand',
                ),
              ),
            ),
            StatsGrid(),
            CardWidget()
          ],
        ));

  }
}

// Container(
// child: IconButton(
// icon: const Icon(
// CustomIcons.archive,
// ),
// color: Colors.white,
// iconSize: 100.0,
// onPressed: () {
// print("Button has been pressed");
// },
// ),
// decoration: BoxDecoration(
// color: Colors.black54,
// // borderRadius: BorderRadius.circular(50),
// shape: BoxShape.circle,
// border: Border.all(
// width: 5,
// color: Colors.red,
// // style: BorderStyle.solid
// ),
// boxShadow: const [
// BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 5)
// ]),
// )

// RichText(
// text: const TextSpan(
// style: TextStyle(
// fontSize: 30.0,
// color: Colors.red,
// fontFamily: "Fredoka",
// fontWeight: FontWeight.bold),
// children: <TextSpan>[
// TextSpan(text: "Hello, "),
// TextSpan(
// style: TextStyle(color: Colors.black),
// children: <TextSpan>[
// TextSpan(text: "Brave "),
// TextSpan(text: "New "),
// TextSpan(
// text: "World",
// style:
// TextStyle(decoration: TextDecoration.underline)),
// ]),
// TextSpan(text: "!"),
// ]),
// )
