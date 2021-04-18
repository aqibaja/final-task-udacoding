part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

//data api register / sigup selesai di get
class SignUpSuccess extends AuthState {
  final SignUpModel signUpModel;
  SignUpSuccess({this.signUpModel});
}

class SignUpLoading extends AuthState {}

class SignUpError extends AuthState {
  final String error;
  SignUpError({this.error});
}

//data api login selesai di get
class SignInSuccess extends AuthState {
  final SignInModel signInModel;
  SignInSuccess({this.signInModel});
}

class SignInFail extends AuthState {
  final SignInFailModel signInFailModel;
  SignInFail({this.signInFailModel});
}

class SignInSaved extends AuthState {
  final String idUSerSave;
  SignInSaved({this.idUSerSave});
}

class SignInOut extends AuthState {
  //final SignInModel signInModel;
  /* SignInProcess({this.signInModel}); */
}

class SignInLoading extends AuthState {}

class SignInError extends AuthState {
  final String error;
  SignInError({this.error});
}
