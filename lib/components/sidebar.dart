import 'package:flutter/material.dart';
import 'package:flutter_auth/provider/storage/storage_provider.dart';
import 'package:flutter_auth/screens/pages/notification_list.dart';
import 'package:flutter_auth/screens/pages/profile.dart';

import '../screens/pages/home_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(5),
        child: Wrap(
          runSpacing: 3,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home page'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage()
                  )),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage())
                );
              }
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationList())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () =>
                StorageProvider().logOut(context),
            ),
          ],
        ),
      );
}
