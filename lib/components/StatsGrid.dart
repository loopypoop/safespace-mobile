import 'package:flutter/material.dart';
import 'package:flutter_auth/model/Indicator.dart';
import 'package:flutter_auth/model/UserDetail.dart';
import 'package:flutter_auth/provider/storage/storage_provider.dart';
import 'package:flutter_auth/provider/user_provider/user_provider.dart';

class StatsGrid extends StatefulWidget {
  const StatsGrid({Key? key}) : super(key: key);

  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Indicator indicator = Indicator(
      id: 0,
      userId: 0,
      temperature: 0,
      heartRate: 0,
      upperBloodPressure: 0,
      lowerBloodPressure: 0,
      bloodOxygen: 0,
      checkTime: 1234,
      isLast: true);

  @override
  void initState() {
    StorageProvider().getUserId().then((userId) {
      if (userId != null) {
        UserProvider().getUserLastIndicator(userId).then((value) {
          if (value == null) {
            StorageProvider().logOut(context);
          } else {
            print(value.id);
            indicator = value;
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'Heart Rate',
                  indicator.heartRate.toString(),
                  ' bpm',
                  Color(0xff50508f),
                  const Icon(
                    Icons.favorite_border,
                    size: 28.0,
                    color: Colors.blue,
                  ),
                ),
                _buildStatCard(
                  'Blood Pressure',
                  indicator.upperBloodPressure.toString() +
                      '/' +
                      indicator.lowerBloodPressure.toString(),
                  ' mmHg',
                  Color(0xff74b455),
                  const Icon(
                    Icons.bloodtype_outlined,
                    size: 28.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'Temperature',
                  indicator.temperature.toString(),
                  ' °C',
                  Color(0xffb23841),
                  const Icon(
                    Icons.health_and_safety_outlined,
                    size: 28.0,
                    color: Colors.blue,
                  ),
                ),
                _buildStatCard(
                  'Blood Oxygen',
                  indicator.bloodOxygen.toString(),
                  ' %',
                  Color(0xffdcda7c),
                  const Icon(
                    Icons.accessibility_outlined,
                    size: 28.0,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, String value, Color color,
      Icon iconData) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Open Sans',
                      color: Colors.black87,
                      fontSize: 17.0),
                ),
                iconData
              ],
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: count,
                      style:
                          const TextStyle(fontFamily: 'QuickSand', color: Colors.black87,fontWeight: FontWeight.bold, fontSize: 20.0)),
                  TextSpan(
                      text: value,
                      style:
                          const TextStyle(fontFamily: 'QuickSand Bold', color: Colors.grey, fontSize: 16.0)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
