import 'package:flutter/material.dart';
import 'package:flutter_auth/styles/colors.dart';

Widget customTextField(
    {String? title,
    String? hint,
    TextEditingController? controller,
        bool? obscure = false,
    int? maxLines = 1}) {
    return Column(
        children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    title!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black
                    ),
                ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: lightGrey
                ),
                child: TextFormField(
                    controller: controller,
                    maxLines: maxLines,
                    obscureText: obscure!,
                    decoration: InputDecoration(hintText: hint, border: InputBorder.none),
                ),
            )
        ],
    );
}
