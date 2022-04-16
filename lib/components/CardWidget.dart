import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildCardWidget('Covid status', 'BLUE', Color(0xff26859b), Icons.favorite,),
                _buildCardWidget('Risk Status', 'YELLOW', Color(0xffd5cc6c), Icons.favorite,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildCardWidget(String title, String count, Color color, IconData iconData) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 100.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
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
              count,
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