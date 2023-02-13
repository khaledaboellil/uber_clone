class RegisterDriverState {}

class RegisterDriverInitialState extends RegisterDriverState{}

class RegisterDriverChangeVisbility extends RegisterDriverState{}


class RegisterDriverLoadingState extends RegisterDriverState{}
class RegisterDriverSuccessState extends RegisterDriverState{}
class RegisterDriverErrorState extends RegisterDriverState{

  late String error ;
  RegisterDriverErrorState(this.error);
}