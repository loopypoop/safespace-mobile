import 'package:flutter/material.dart';
import 'package:flutter_auth/components/CardWidget.dart';
import 'package:flutter_auth/components/StatsGrid.dart';
import 'package:flutter_auth/components/sidebar.dart';
import 'package:flutter_auth/styles/colors.dart';

import '../../model/Button.dart';
import '../../model/Indicator.dart';
import '../../provider/storage/storage_provider.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../shared/custom_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Indicator indicator = Indicator(
      id: 0,
      userId: 0,
      temperature: 0,
      heartRate: 0,
      upperBloodPressure: 0,
      lowerBloodPressure: 0,
      bloodOxygen: 0,
      checkTime: 0,
      isLast: true);

  @override
  void initState() {
    StorageProvider().getUserId().then((userId) {
      UserProvider().getUserLastIndicator(userId).then((value) {
        indicator = value;
        build(context);
      });
    });

    super.initState();
  }

  Future<Indicator>? fetchData() async {
    var userId = StorageProvider().getUserId();
    var lastIndicator = UserProvider().getUserLastIndicator(await userId);

    return lastIndicator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          title: const Text("SafeSpace"),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: FutureBuilder<Indicator>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Wrap(
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
                    StatsGrid(indicator: indicator),
                    CardWidget(indicator: indicator)
                  ],
                );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

