import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medecin_warehouse/core/cubit/Auth_cubit/Auth_states.dart';
import 'package:medecin_warehouse/data/model/user_model.dart';
import 'package:medecin_warehouse/services/authservie.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  UserModel? user;

  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2));

    try {
      dynamic responseBody = await Authservice().login(
        phoneNumber: phoneNumber,
        password: password,
      );
      user = UserModel.fromJson(responseBody);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(msg: e.toString().substring(10)));
    }
  }
}

//----------------------------------------//

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitial());

  UserModel? user;

  Future<void> Signup(
      {required String phoneNumber,
      required String password,
      required String name,
      required String email,
      required String confirmpassword}) async {
    emit(SignupLoading());

    await Future.delayed(const Duration(seconds: 2));

    try {
      dynamic responseBody = await Authservice().Signup(
          phoneNumber: phoneNumber,
          name: name,
          email: email,
          password: password,
          confirmpassword: confirmpassword);

      user = UserModel.fromJson(responseBody);
     
      emit(SignupSuccess());
      
    } catch (e) {
      emit(SignupFailure(msg: e.toString().substring(10)));
    }
  }
}
