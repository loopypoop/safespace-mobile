import 'package:flutter/material.dart';
import 'package:flutter_auth/model/UserDetail.dart';

import '../model/Indicator.dart';
import '../provider/storage/storage_provider.dart';
import '../provider/user_provider/user_provider.dart';

class CardWidget extends StatefulWidget {

  final Indicator indicator;

  CardWidget({Key? key, required this.indicator}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  UserDetail userDetail = UserDetail(
      id: 0,
      firstName: '',
      lastName: '',
      position: '',
      riskStatus: '',
      covidStatus: '',
      phoneNumber: '',
      dateOfBirth: 0,
      email: '',
      userId: 0);

  @override
  void initState() {
    StorageProvider().getUserId().then((userId) {
      UserProvider().getUserById(userId: userId.toString()).then((value) {
        userDetail = value;
        build(context);
      });
    });

    super.initState();
  }

  Future<UserDetail>? fetchData() async {
    var userId = StorageProvider().getUserId();
    var _userDetail = UserProvider().getUserById(
        userId: await userId);

    return _userDetail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetail>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.23,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        _buildCardWidget(
                            'Covid status', userDetail.covidStatus),
                        //Color(0xff26859b)
                        _buildCardWidget(
                            'Risk Status', userDetail.riskStatus),
                        //Color(0xffd5cc6c)
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  Expanded _buildCardWidget(String title, String status) {
    return
      Expanded(
        child: Container(
          margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 100.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: status == 'BLUE' ? Color(0xff26859b) : status == 'YELLOW'
                ? Color(0xffd5cc6c) : status == 'GREEN' ? Colors.green
                : status == 'RED' ? Colors.red : Colors.black,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                    fontFamily: 'QuickSand Bold',
                    color: Colors.white,
                    fontSize: 18.0
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
