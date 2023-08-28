import 'package:catrx/modules/login/cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/network/remote/dio_helper.dart';


class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  bool hidePass = true;
  IconData suffixIcon = Icons.visibility;
  UserLoginModel? userModel;

  void login({
    required String email,
    required String password,
  }) {
    emit(UserLoadingState());

    DioHelper.postData(
      url: 'https://student.valuxapps.com/api/login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      userModel = UserLoginModel(value.data);
      token = userModel!.data!.token;
      emit(UserLoginSuccessfulState(userModel!));
    }).catchError((error) {
      debugPrint('Login Error ${error.toString()}');
      emit(UserLoginErrorState(error));
    });
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(UserLoadingState());

    DioHelper.postData(
      url: 'https://student.valuxapps.com/api/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      userModel = UserLoginModel(value.data);
      emit(UserSignUpSuccessfulState());
    }).catchError((error) {
      debugPrint('SignUp Error ${error.toString()}');
      emit(UserSignUpErrorState());
    });
  }

  void getProfile() {
    DioHelper.getData(
      url: "https://student.valuxapps.com/api/profile",
      token: token,
    ).then((value) {
      userModel = UserLoginModel(value.data);
      debugPrint(userModel!.data!.name);
      emit(UserGetProfileSuccessfulState());
    }).catchError((error) {
      debugPrint('Get Profile Error ${error.toString()}');
      emit(UserGetProfileErrorState());
    });
  }

  void update({
    required String name,
    required String email,
    required String phone,
    required String image,
  }) {
    emit(UserLoadingState());

    DioHelper.putData(
            url: 'https://student.valuxapps.com/api/update-profile',
            data: {
              'name': name,
              'email': email,
              'phone': phone,
              'image': image,
            },
            token: token)
        .then((value) {
      userModel = UserLoginModel(value.data);
      debugPrint(value.toString());
      emit(UserUpdateSuccessfulState());
    }).catchError((error) {
      debugPrint('Update Error ${error.toString()}');
      emit(UserUpdateErrorState());
    });
  }

  void hidePassword() {
    hidePass = !hidePass;
    suffixIcon = hidePass ? Icons.visibility : Icons.visibility_off;

    emit(UserHidePasswordState());
  }
}
