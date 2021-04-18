import 'dart:convert';
import 'package:flutter_ecommerce_app/models/SignInFailModel.dart';
import 'package:flutter_ecommerce_app/models/SignInModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class SignInRepo {
  Future<dynamic> getLoginData(String email, String password);
}

class SignInService implements SignInRepo {
  SignInModel signInData;
  SignInFailModel signInFailData;
  @override
  Future<dynamic> getLoginData(String email, String password) async {
    Map data = {
      'email': email,
      'password': password,
    };
    String bodyPost = json.encode(data);
    String url = Urls.SIGN_IN_URL;

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 201) {
      signInData = SignInModel.fromJson(body);
      return signInData;
    } else if (statusCode == 400) {
      signInFailData = SignInFailModel.fromJson(body);
      return signInFailData;
    } else {
      return signInData;
    }
  }
}
