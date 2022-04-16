import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/model/Indicator.dart';
import 'package:flutter_auth/model/UserDetail.dart';
import 'package:flutter_auth/utils/routers.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_url.dart';
import '../../screens/authentication/login.dart';
import '../storage/storage_provider.dart';

class UserProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

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

  Future<Indicator?> getUserLastIndicator(String userId) async {
    return StorageProvider().getToken().then((token) async {
      if (token == '') {
        PageNavigator().nextPageOnly(page: const LoginPage());
        return null;
      } else {
        final response = await http.get(
            Uri.parse("$requestBaseUrl/business/indicator/user/last/$userId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            });

        if (response.statusCode == 200 || response.statusCode == 201) {
          print(response.body);
          Indicator indicator = Indicator.fromJson(jsonDecode(response.body));
          return indicator;
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
