import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/models/user_model.dart';
import 'package:in_media/modules/register_screen/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterInit());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);


  IconData suffixIcon = Icons.visibility_off_outlined;
  var passwordVisibility =true;
  void showPasswordVisibility(){
    passwordVisibility =!passwordVisibility;
    suffixIcon = passwordVisibility?Icons.visibility_off_outlined:Icons.visibility;
    emit(SocialRegisterChangePasswordVisibility());
  }

  void userRegister({
  required email,
  required password,
  required name,
  required phone,
}){
    emit(SocialRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      createUser(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
      );
    }).catchError((error){
      emit(SocialCreateUserError(error));
    });
  }

  void createUser({
    required email,
    required name,
    required phone,
    required uId,
  }){
    UserModel _userModel = UserModel(
      name: name,
      phone: phone,
      uId: uId,
      email: email,
      bio: "Write Your Bio....",
      image: 'https://t3.ftcdn.net/jpg/03/01/94/34/240_F_301943459_hZqG7C4F3nnACx811k2CwS4YfomRT1n1.jpg',
      cover:'https://t4.ftcdn.net/jpg/04/48/64/71/240_F_448647180_fwUKS89mZGqU46lRTIcpAFETE0Sy3Aqh.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(_userModel.toMap())
        .then((value){
      emit(SocialCreateUserSuccess(uId: uId));
    }).catchError((error){
      emit(SocialCreateUserError(error));
    });
  }


}
