import 'package:flutter/material.dart';

import '../model/Event.dart';
import '../shared/custom_icons.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isEnabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    return Card(
      color: Colors.orange,
      elevation: 5,
      shadowColor: Colors.red,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        enabled: _isEnabled,
        title: Text(
          widget.event.name,
          style: TextStyle(fontSize: 20),
        ),
        subtitle:
            Text("${widget.event.location} ${widget.event.startDateTime}"),
        leading: const Icon(
          CustomIcons.add_box,
          size: 40,
          color: Colors.black,
        ),
        trailing: IconButton(
          onPressed: () {
            print("pressed");
          },
          icon: IconButton(
            icon: _isEnabled ? Icon(Icons.lock_outline) : Icon(Icons.lock_open),
            onPressed: () => setState(() {
              _isEnabled = !_isEnabled;
            }),
          ),
        ),
        onTap: () {
          print("tapped");
        },
      ),
    );
  }
}
