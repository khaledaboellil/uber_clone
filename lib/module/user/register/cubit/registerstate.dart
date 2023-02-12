class RegisterState {}

class RegisterInitialState extends RegisterState{}

class RegisterChangeVisbility extends RegisterState{}


class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{

  late String error ;
  RegisterErrorState(this.error);
}