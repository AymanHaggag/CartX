import '../../../models/login_model.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoginSuccessfulState extends UserStates {
  late final UserLoginModel loginModel;

  UserLoginSuccessfulState(this.loginModel);
}

class UserLoginErrorState extends UserStates {
  final String error;

  UserLoginErrorState(this.error);
}

class UserSignUpSuccessfulState extends UserStates {}

class UserSignUpErrorState extends UserStates {}

class UserUpdateSuccessfulState extends UserStates {}

class UserUpdateErrorState extends UserStates {}

class UserHidePasswordState extends UserStates {}

class UserGetProfileSuccessfulState extends UserStates {
  // final UserLoginModel userModel;
  //
  // ShopGetProfileSuccessfulState(this.userModel);

}

class UserGetProfileErrorState extends UserStates {}


