import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/SignInService.dart';
import 'package:flutter_ecommerce_app/API_services/SignUpService.dart';
import 'package:flutter_ecommerce_app/models/SignInFailModel.dart';
import 'package:flutter_ecommerce_app/models/SignInModel.dart';
import 'package:flutter_ecommerce_app/models/SignUpModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpRepo signUpRepo;
  SignUpModel data;
  SignInModel dataSignIn;
  SharedPreferences sharedPreferences; // menyimpan state ke memory

  AuthBloc({this.signUpRepo}) : super(AuthInitial());

/*   void onRegister(String username, String email, String password, String gender,
      String noHp) {
    add(RegisterEvent(
        username: username,
        password: password,
        email: email,
        gender: gender,
        noHp: noHp));
  } */

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      try {
        yield SignUpLoading();
        //Future.delayed(Duration(seconds: 2));
        data = await SignUpService().getRegisterData(event.username,
            event.email, event.gender, event.password, event.noHp);
        yield SignUpSuccess(signUpModel: data);
      } catch (e) {
        SignUpError(error: e.toString());
      }
    } else if (event is LoginEvent) {
      try {
        yield SignInLoading();
        //Future.delayed(Duration(seconds: 2));
        var data =
            await SignInService().getLoginData(event.email, event.password);
        if (data.success == true) {
          yield SignInSuccess(signInModel: data);
        }
        yield SignInFail(signInFailModel: data);
      } catch (e) {
        SignInError(error: e.toString());
      }
    }
    //check save login in memory
    else if (event is CheckLoginEvent) {
      yield SignUpLoading();
      //check shared info
      sharedPreferences = await SharedPreferences.getInstance();
      var data = sharedPreferences.get('id_user');
      print(data);
      if (data != null) {
        yield SignInSaved(idUSerSave: data);
      } else {
        yield SignInOut();
      }
    }
    // logout event
    else if (event is LogOutEvent) {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      yield SignInOut();
    }
    //clear state
    else if (event is ClearEvent) {
      yield AuthInitial();
    }
  }
}
