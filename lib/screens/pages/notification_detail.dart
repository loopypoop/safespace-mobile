import 'package:flutter/material.dart';
import 'package:flutter_auth/components/sidebar.dart';
import 'package:flutter_auth/model/NotificationEntity.dart';
import 'package:flutter_auth/shared/button.dart';
import 'package:flutter_auth/styles/colors.dart';
import 'package:intl/intl.dart';

import '../../provider/storage/storage_provider.dart';
import '../../provider/user_provider/user_provider.dart';

class NotificationDetail extends StatefulWidget {
  final NotificationEntity notification;

  const NotificationDetail({Key? key, required this.notification})
      : super(key: key);

  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {

  @override
  void initState() {
    StorageProvider().getUserId().then((userId) {
      if (userId != null) {
        UserProvider().getNotificationById(widget.notification.id).then((value) {
          if (value != null) {
            // StorageProvider().logOut(context);
            print(value.id);
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMM dd, HH:mm');
    final String formatted = formatter.format(now);

    return Scaffold(
      appBar: AppBar(
        // title: const Text("SafeSpace"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: FittedBox(
        child: Container(
          // height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 2.0)
              ]),
          child: Column(
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                widget.notification.topic,
                style: TextStyle(
                    fontSize: 20.0, fontFamily: 'QuickSand Bold', height: 1.2),
              ),
              Text(formatted)
            ]),
            const SizedBox(height: 22.0),
            Text(
              widget.notification.content,
              style:
                  TextStyle(fontFamily: 'Arial', fontSize: 16.0, height: 1.5),
            ),
                const SizedBox(height: 150),

                Align(
              alignment: Alignment.bottomCenter,
                child: customButton(
                  tap: () {
                    print('iui');
                  },
                  context: context,
                  text: 'Recheck'
                ))
          ]),
        ),
      ),
    );
  }
}
