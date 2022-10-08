import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/modules/login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialInitLogin());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_off_outlined;
  var passwordVisibility =true;
  void showPasswordVisibility(){
    passwordVisibility =!passwordVisibility;
    suffixIcon = passwordVisibility?Icons.visibility_off_outlined:Icons.visibility;
    emit(SocialLoginChangePasswordVisibility());
  }
  void userLogin({
  required String email,
  required String password,
}){
    emit(SocialLoginLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(SocialLoginSuccess(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginError(error));
    });
  }
}