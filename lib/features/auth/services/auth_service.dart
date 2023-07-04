// import 'dart:html';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:amazon_clone/models/User.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
// ...

class AuthService {
  //signup
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: 0,
          name: name,
          email: email,
          password: password,
          token: '',
          type: '');

      final String userJson = jsonEncode(user); // Serialize user to JSON string

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: userJson,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // Fix typo here
        },
      );
      print("hello");
      print(userJson);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account has been created');
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // Fix typo here
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(res.body);
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
