import 'package:flutter_ecommerce_app/models/SignInModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareInfo {
  SharedPreferences sharedPreferences;

  //save  info logged in to shared preferences
  void shareLoginSave(SignInModel signInModel) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "id_user", signInModel.data.user.idKonsumen.toString());
  }
}
