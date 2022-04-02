import 'package:flutter/material.dart';
import 'package:flutter_auth/provider/storage/storage_provider.dart';
import 'package:flutter_auth/screens/authentication/login.dart';
import 'package:flutter_auth/screens/pages/home_page.dart';
import 'package:flutter_auth/utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 1), () {
      StorageProvider().getToken().then((value) {
        if (value == '') {
          PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        } else {
          PageNavigator(ctx: context).nextPageOnly(page: HomePage());
        }
      });
    });
  }
}
