import 'package:flutter/material.dart';
import 'package:flutter_auth/components/sidebar.dart';
import 'package:flutter_auth/model/NotificationEntity.dart';
import 'package:flutter_auth/styles/colors.dart';
import 'package:lit_relative_date_time/lit_relative_date_time.dart';

import '../../model/Button.dart';
import '../../provider/storage/storage_provider.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../shared/custom_icons.dart';
import 'notification_detail.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<NotificationEntity> notifications = [];

  @override
  void initState() {

    StorageProvider().getUserId().then((userId) {
      UserProvider().getNotificationsUserId(userId).then((value) {
          notifications = value;
          build(context);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView.separated(
          physics: const ClampingScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, i) {
            return ListTile(
              // leading: Container(
              //   child: const Icon(Icons.notification_important_sharp, size: 45),
              //   height: 50.0,
              //   width: 50.0,
              // ),
              trailing: Container(
                height: 50.0,
                width: 50.0,
                child: Container(
                  child: AnimatedRelativeDateTimeBuilder(
                    animateOpacity: true,
                    date: notifications[i].createdAt,
                    builder: (relDateTime, formatted) {
                      return Text(formatted,
                          style: TextStyle(
                              color: notifications[i].isSeen == false ? Colors.black : Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)
                      );
                    },
                  ),
                ),
              ),
              title: Text(notifications[i].topic,
                  style: TextStyle(
                      color: notifications[i].isSeen == false ? Colors.black : Colors.black54, fontWeight: FontWeight.bold)),
              subtitle: Text(
                notifications[i].content.length > 42
                    ? (notifications[i].content.substring(0, 42) + ' ...')
                    : notifications[i].content,
                style: TextStyle(color: notifications[i].isSeen == false ? Colors.black : Colors.black54,),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationDetail(notification: notifications[i])));
              },

              enabled: true,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }
}
