import 'dart:convert';
import 'package:flutter_ecommerce_app/models/SignUpModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class SignUpRepo {
  Future<SignUpModel> getRegisterData(String username, String email,
      String jenisKelamin, String password, String noHp);
}

class SignUpService implements SignUpRepo {
  SignUpModel signUpData;
  @override
  Future<SignUpModel> getRegisterData(String username, String email,
      String jenisKelamin, String password, String noHp) async {
    Map data = {
      'username': username,
      'email': email,
      'jenis_kelamin': jenisKelamin,
      'password': password,
      'no_hp': noHp
    };
    String bodyPost = json.encode(data);
    String url = Urls.SIGNUP_URL;

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 201 || statusCode == 400) {
      signUpData = SignUpModel.fromJson(body);
      return signUpData;
    } else {
      return signUpData;
    }
  }
}
