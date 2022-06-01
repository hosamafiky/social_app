// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/login_models/login_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/cubit/register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibiltyState());
  }

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        image:
            'https://img.freepik.com/free-photo/man-presenting-something_1368-3697.jpg?t=st=1651063174~exp=1651063774~hmac=a13af29211e5e61a269aa540e3c653ac73d1d70788b6fdd3f40e4b57c3c85d09&w=826',
        cover:
            'https://img.freepik.com/free-photo/horizontal-shot-stupefied-young-man-looks-surprisingly-indicates-down-being-stunned-by-something-unbelievable-wears-casual-bright-red-t-shirt-stands-against-white-wall_273609-16255.jpg?t=st=1651067464~exp=1651068064~hmac=e8c127c0715fb0c9806f23bd1a256f905d40d8db9d3006736024146e7503b6d2&w=996',
        bio: 'Write your bio',
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String bio,
    required String image,
    required String cover,
    required String uId,
  }) {
    emit(UserCreateLoadingState());
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: image,
      cover: cover,
      bio: bio,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateSuccessState(model.uId!));
    }).catchError((error) {
      print(error.toString());
      emit(UserCreateErrorState(error.toString()));
    });
  }
}
