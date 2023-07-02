// import 'dart:html';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/util.dart';
import 'package:amazon_clone/models/User.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
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
        // id: '',
        name: name,
        email: email,
        password: password,
      );

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
}
