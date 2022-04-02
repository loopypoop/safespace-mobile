import 'package:flutter/material.dart';
import 'package:flutter_auth/provider/auth_provider/auth_provider.dart';
import 'package:flutter_auth/provider/storage/storage_provider.dart';
import 'package:flutter_auth/splash.dart';
import 'package:flutter_auth/styles/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => StorageProvider()),
        ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: primaryColor
          ),
          floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: primaryColor),
          primaryColor: primaryColor
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
