abstract class LoginStates {}

class Initial extends LoginStates {}

class IsLoading extends LoginStates {}

class LoginError extends LoginStates {
  final String error;
  LoginError(this.error);
}

class TogglePassword extends LoginStates {}

class ImagePicked extends LoginStates {}

class LoginSuccess extends LoginStates{}

class SocialLoginSuccess extends LoginStates{

  final String userName;
  final bool isNewUser;

  SocialLoginSuccess(this.userName, this.isNewUser);



}