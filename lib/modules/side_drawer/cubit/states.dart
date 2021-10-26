abstract class SideDrawerStates {}

class Initial extends SideDrawerStates {}

class IsLoading extends SideDrawerStates {}

class SideDrawerError extends SideDrawerStates {
  final String error;
  SideDrawerError(this.error);
}

class LogoutSuccess extends SideDrawerStates{}