import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/model/Indicator.dart';
import 'package:flutter_auth/model/NotificationEntity.dart';
import 'package:flutter_auth/model/UserDetail.dart';
import 'package:flutter_auth/utils/routers.dart';
import 'package:http/http.dart' as http;
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/lit_relative_date_time.dart';

import '../../constants/app_url.dart';
import '../../screens/authentication/login.dart';
import '../storage/storage_provider.dart';

class UserProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  Future<UserDetail> getUserById({required String userId}) async {
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        throw Exception('Failed to create album.');
      } else {
        final response = await http.get(
            Uri.parse("$requestBaseUrl/business/user-detail/byUserId/$userId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            });

        if (response.statusCode == 200 || response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          UserDetail user = UserDetail.fromJson(jsonDecode(response.body));
          return user;
        } else if (response.statusCode == 401) {
          print('Unauthorized!!!');

          throw Exception('Failed to get user details.');
        } else {
          throw Exception('Failed to get user details.');
        }
      }
    });
  }

  //TODO indicator provider
  Future<Indicator> getUserLastIndicator(String userId) async {
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        throw Exception('Token is unreached!');
      } else {
        final response = await http.get(
            Uri.parse("$requestBaseUrl/business/indicator/user/last/$userId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            });

        if (response.statusCode == 200 || response.statusCode == 201) {
          Indicator indicator = Indicator.fromJson(jsonDecode(response.body));
          return indicator;
        } else if (response.statusCode == 401) {
          PageNavigator().nextPageOnly(page: const LoginPage());
          throw Exception('Unauthorized.');
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to get indicators.');
        }
      }
    });
  }

  //TODO notification provider
  Future<List<NotificationEntity>> getNotificationsUserId(String userId) async {
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return [];
      } else {
        final response = await http.get(
            Uri.parse("$requestBaseUrl/notify/get/all/$userId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            });

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseJson = json.decode(response.body);
          List<NotificationEntity> notifications =
              List<NotificationEntity>.from((responseJson['content'])
                  .map((data) => NotificationEntity.fromJson(data)));
          // print(notifications[0].createdAt);
          print(notifications[0].createdAt);
          return notifications;
        } else if (response.statusCode == 401) {
          print('Unauthorized!!!');

          return [];
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to get notifications.');
        }
      }
    });
  }

  //TODO notification provider
  Future<NotificationEntity?> getNotificationById(int notificationId) async {
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return null;
      } else {
        final response = await http.get(
            Uri.parse("$requestBaseUrl/notify/get/$notificationId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            });

        if (response.statusCode == 200 || response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          NotificationEntity notification =
              NotificationEntity.fromJson(jsonDecode(response.body));
          return notification;
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
            });

        if (response.statusCode == 200 || response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print(response.body);
          UserDetail user = UserDetail.fromJson(jsonDecode(response.body));
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

  Future<String> updateUser(Object user) async {
    final jsonUser = json.encode(user);
    print(jsonUser);
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return "";
      } else {
        try {
          final response = await http.put(
              Uri.parse("$requestBaseUrl/business/user-detail/createUpdate"),
              body: jsonUser,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              });

          print(response.statusCode);
          if (response.statusCode == 200 || response.statusCode == 201) {
            // If the server did return a 201 CREATED response,
            // then parse the JSON.
            UserDetail user = UserDetail.fromJson(jsonDecode(response.body));
            print(user.firstName);
            return "Personal information changed.";
          } else if (response.statusCode == 401) {
            PageNavigator().nextPageOnly(page: const LoginPage());
          } else {
            return "Please try again later.";
          }
        } on SocketException catch (_) {
          return "Internet connection is not available.";

          _resMessage = "Internet connection is not available.";
          notifyListeners();
        } catch (e) {
          return "Please try again.";

          _resMessage = "Please try again.";
          notifyListeners();
        }
      }
      return "";
    });
  }

  Future<String> changePassword(Object changeRequest) async {
    final jsonBody = json.encode(changeRequest);
    print(jsonBody);
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return "";
      } else {
        try {
          final response = await http.post(
              Uri.parse("$requestBaseUrl/change-password"),
              body: jsonBody,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              });

          print(response.statusCode);
          if (response.statusCode == 200 || response.statusCode == 201) {
            return response.body;
          } else if (response.statusCode == 401) {
            PageNavigator().nextPageOnly(page: const LoginPage());
          } else {
            return "Please try again later.";
          }
        } on SocketException catch (_) {
          return "Internet connection is not available.";
        } catch (e) {
          return "Please try again.";
        }
      }
      return "";
    });
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
