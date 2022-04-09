import 'package:flutter/material.dart';
import 'package:flutter_auth/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth/provider/auth_provider/auth_provider.dart';
import 'package:flutter_auth/shared/button.dart';
import 'package:flutter_auth/shared/text_field.dart';
import 'package:flutter_auth/utils/snack_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true,
      backgroundColor: primaryColor),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                        title: 'Username',
                        controller: _username,
                        hint: 'Enter your username'),
                    customTextField(
                        title: 'Password',
                        controller: _password,
                        obscure: true,
                        hint: 'Enter your password'),
                    Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showMessage(
                              message: auth.resMessage, context: context);

                          auth.clear();
                        }
                      });
                      return customButton(
                          text: 'Go!',
                          tap: () {
                            if (_username.text.isEmpty ||
                                _password.text.isEmpty) {
                              showMessage(
                                  message: 'All fields are required',
                                  context: context);
                            } else {
                              auth.loginUser(
                                  username: _username.text.trim(),
                                  password: _password.text.trim(),
                                  context: context);
                            }
                          },
                          context: context,
                          status: auth.isLoading);
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
}
