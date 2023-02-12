class LoginState {}

class LoginInitialState extends LoginState{}
class LoginChangeVisbility extends LoginState{}

class LoginLoadingState extends LoginState{}
class LoginSucessState extends LoginState{}
class LoginErrorState extends LoginState{
  late String error ;
  LoginErrorState(this.error);
}
class GoogleLoadingState extends LoginState{}
class GoogleErrorState extends LoginState{
  late String error ;
  GoogleErrorState(this.error);
}
class GoogleSuccessState extends LoginState{}

class FacebookLoadingState extends LoginState{}