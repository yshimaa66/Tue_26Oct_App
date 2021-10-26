abstract class HomeStates {}

class Initial extends HomeStates {}

class IsLoading extends HomeStates {}

class HomeError extends HomeStates {
  final String error;
  HomeError(this.error);
}

class InitializeCurrentUser extends HomeStates {}