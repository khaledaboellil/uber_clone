class LoginDriverState {}

class LoginDriverInitialState extends LoginDriverState{}
class LoginDriverChangeVisbility extends LoginDriverState{}

class LoginDriverLoadingState extends LoginDriverState{}
class LoginDriverSucessState extends LoginDriverState{}
class LoginDriverErrorState extends LoginDriverState{
  late String error ;
  LoginDriverErrorState(this.error);
}
class GoogleLoadingState extends LoginDriverState{}
class GoogleErrorState extends LoginDriverState{
  late String error ;
  GoogleErrorState(this.error);
}
class GoogleSuccessState extends LoginDriverState{}

class FacebookLoadingState extends LoginDriverState{}