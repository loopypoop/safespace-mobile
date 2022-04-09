import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/model/UserDetail.dart';
import 'package:flutter_auth/utils/routers.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_url.dart';
import '../../screens/authentication/login.dart';
import '../storage/storage_provider.dart';

class UserProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  Future<UserDetail?> getUserById({required String userId}) async {

    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return null;
      } else {
        final response = await http.get(
          Uri.parse("$requestBaseUrl/business/user-detail/byUserId/" + userId),
          // Send authorization headers to the backend.
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $token',
          },
        );
        final responseJson = jsonDecode(response.body);
        return responseJson;
      }
    });


  }

  Future<UserDetail?> getUser(String userId) async {

    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return null;
      } else {
        final response = await http.get(
            Uri.parse("$requestBaseUrl/business/user-detail/byUserId/$userId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            }
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          UserDetail user = UserDetail.fromJson(jsonDecode(response.body));
          print(user.firstName);
          return user;
        } else if (response.statusCode == 401) {
          print('Unauthorized!!!');

          return null;
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to create album.');
        }
      }
    });
  }

  // Future<UserDetail?> getUserById({required String userId}) async {
  //   String url = "$requestBaseUrl/business/user-detail/byUserId/" + userId;
  //
  //   StorageProvider().getToken().then((token) async {
  //     if (token == '') {
  //       PageNavigator().nextPageOnly(page: const LoginPage());
  //     } else {
  //       http.Response req = await http.get(
  //           Uri.parse(url),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //           }
  //       );
  //
  //
  //       print(req.statusCode);
  //       if(req.statusCode == 200 || req.statusCode == 201) {
  //         UserDetail response = json.decode(req.body);
  //         // print(response);
  //         return response;
  //       } else {
  //         return null;
  //       }
  //     }
  //   });
  //
  // }
}
