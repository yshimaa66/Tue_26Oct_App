abstract class RegisterStates {}

class Initial extends RegisterStates {}

class IsLoading extends RegisterStates {}

class RegisterError extends RegisterStates {
  final String error;
  RegisterError(this.error);
}

class TogglePassword extends RegisterStates {}

class ImagePicked extends RegisterStates {}

class ImageUpload extends RegisterStates {}

class RegisterSuccess extends RegisterStates{

  final String userName;

  RegisterSuccess(this.userName);


}