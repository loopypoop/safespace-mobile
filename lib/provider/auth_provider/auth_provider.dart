import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/constants/app_url.dart';
import 'package:flutter_auth/provider/storage/storage_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_auth/utils/routers.dart';

import '../../screens/authentication/login.dart';
import '../../screens/pages/home_page.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  void registerUser({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/";

    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "password": password
    };

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available.";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again.";
      notifyListeners();

      print(":::: $e");
    }
  }

  void loginUser({
    required String username,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/login";

    final body = {"username": username, "password": password};

    try {
      http.Response req = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final String token = req.body;
        Map<String, dynamic> payload = Jwt.parseJwt(token);

        _isLoading = false;
        _resMessage = "Login successful!";
        notifyListeners();

        //Save users data and then navigate to homepage
        final userId = payload['id'].toString();
        StorageProvider().saveToken(token);
        StorageProvider().saveUserId(userId);
        PageNavigator(ctx: context).nextPageOnly(page: HomePage());
      } else if (req.statusCode == 401) {
        _isLoading = false;
        _resMessage = 'Wrong username or password.';
        notifyListeners();
      } else {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'];
        notifyListeners();

      }
    } on SocketException catch (e) {
      _isLoading = false;
      _resMessage = "Internet connection is not available.";
      notifyListeners();

      print(e);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again.";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
