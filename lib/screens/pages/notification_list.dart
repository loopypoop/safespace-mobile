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

  Future<List<NotificationEntity>>? fetchData() async {
    var userId = StorageProvider().getUserId();
    var notifications = UserProvider().getNotificationsUserId(await userId);

    return notifications;
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
        body: FutureBuilder<List<NotificationEntity>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: notifications.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      trailing: Container(
                        height: 50.0,
                        width: 85.0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: AnimatedRelativeDateTimeBuilder(
                            animateOpacity: true,
                            date: notifications[i].createdAt,
                            builder: (relDateTime, formatted) {
                              return Text(formatted,
                                  style: TextStyle(
                                      color: notifications[i].isSeen == false
                                          ? Colors.black
                                          : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12));
                            },
                          ),
                        ),
                      ),
                      title: Text(notifications[i].topic,
                          style: TextStyle(
                              color: notifications[i].isSeen == false
                                  ? Colors.black
                                  : Colors.black54,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        notifications[i].content.length > 38
                            ? (notifications[i].content.substring(0, 38) +
                                ' ...')
                            : notifications[i].content,
                        style: TextStyle(
                          color: notifications[i].isSeen == false
                              ? Colors.black
                              : Colors.black54,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationDetail(
                                notification: notifications[i])));
                      },
                      enabled: true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
