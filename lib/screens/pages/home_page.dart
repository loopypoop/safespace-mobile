
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/sidebar.dart';
import 'package:flutter_auth/styles/colors.dart';

import '../../components/event_card.dart';
import '../../model/Button.dart';
import '../../model/Event.dart';
import '../../shared/custom_icons.dart';


class HomePage extends StatelessWidget {

  List<Event> events = [
    Event(
        name: "Event 1",
        location: "Location 1",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 2",
        location: "Location 2",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 3",
        location: "Location 3",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 4",
        location: "Location 4",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 5",
        location: "Location 5",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 6",
        location: "Location 6",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 7",
        location: "Location 7",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 8",
        location: "Location 8",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 9",
        location: "Location 9",
        startDateTime: DateTime.now()),
    Event(
        name: "Event 10",
        location: "Location 10",
        startDateTime: DateTime.now()),
  ];
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
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(40),
          child:
          /* Wrap(spacing: 50, runSpacing: 40, children: [ */
          ListView.builder(
            // separatorBuilder: (context, index) => Divider(color: Colors.black, thickness: 2),
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            itemCount: events.length,

            itemBuilder: (_, i) => EventCard(event: events[i]),
          )
        // ]),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Text("Add"),
      ),
    );
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
