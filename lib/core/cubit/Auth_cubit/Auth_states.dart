abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginFailure extends LoginStates {
  final String msg;
  LoginFailure({required this.msg});
} 
class LoginSuccess extends LoginStates {}


//------------------------------------------------//

abstract class SignupStates {}

class SignupInitial extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupFailure extends SignupStates {
  final String msg;
  SignupFailure({required this.msg});
}

class SignupSuccess extends SignupStates {}
