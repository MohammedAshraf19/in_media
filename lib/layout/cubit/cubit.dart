import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/models/user_model.dart';
import 'package:in_media/modules/home_screen/home_Screen.dart';
import 'package:in_media/shared/components/constants.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import '../../modules/chat_screen/chat_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../modules/profile/profile_screen.dart';
class SocialLayoutCubit extends Cubit<SocialLayoutStates>{
  SocialLayoutCubit() : super(SocialLayoutInit());
  static SocialLayoutCubit get(context)=>BlocProvider.of(context);

  int currentIndex =0;
  List<Widget>screen =[
    const HomeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  List<String>name =[
    'Home',
    'Chats',
    'Setting',
  ];
  void changeBottomNav(int index){
      currentIndex = index;
      emit(SocialChangeBottomNavState());
  }


  UserModel? userModel ;
  void getUserData(){
    emit(SocialGetUserDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          userModel = UserModel.fromJson(value.data()!);
          emit(SocialGetUserDataSuccess());
    })
        .catchError((error){
          emit(SocialGetUserDataError());
    });
  }


  // Profile
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
    }
  }



  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    @required name,
    @required bio,
    @required phone,
  }){
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      })
          .catchError((error){
        emit(SocialUpdateProfileErrorState());
      }
      );
    })
        .catchError((error){
      emit(SocialUpdateProfileErrorState());
    });
  }

  void uploadProfileCover({
    @required name,
    @required bio,
    @required phone,
  }){
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        updateUser(
            name: name,
            bio: bio,
            phone: phone,
            cover: value
        );
      })
          .catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }


  void updateUser({
    required name,
    required bio,
    required phone,
    String? image,
    String? cover,
  }){
    emit(SocialUpdateProfileLoadingState());
    UserModel usermodel = UserModel(
        email: userModel!.email,
        name: name,
        phone: phone,
        uId: userModel!.uId,
        image:image?? userModel!.image,
        cover:cover?? userModel!.cover,
        bio: bio,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(usermodel.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(SocialUpdateProfileErrorState());
    });
  }

  void removeProfileImage(){
    profileImage =null;
    emit(SocialRemoveProfileImageState());
  }
  void removeCoverImage(){
    coverImage =null;
    emit(SocialRemoveCoverImageState());
  }


  // Post
  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialUpdatePostImageLoadingState());
    } else {
      emit(SocialUpdatePostImageErrorState());
    }
  }

  void uploadPostImage({
    @required dateText,
    @required text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        createPost(
            dateText: dateText
            , text: text,
            postImage: value
        );
      })
          .catchError((error){
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateText,
    String? postImage,
    required String text,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      text: text,
      dateTime:dateText,
      postImage: postImage??'',
      image:userModel!.image,

    );
    FirebaseFirestore.instance.collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  void removePostImage(){
    postImage =null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel>posts=[];
  void getPosts(){
    emit(SocialGetPostsLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      for (var element in value.docs){
        element.reference
            .collection('likes')
            .get()
            .then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          posId.add(element.id);

        }).catchError((error){
        });
      }
      emit(SocialGetPostsSuccess());
    })
        .catchError((error){
      emit(SocialGetPostsError(error.toString()));
    });
  }

  List<String>posId=[];
  List<int> likes =[];

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value) {
      emit(SocialLikePostSuccessState());
    })
        .catchError((onError){
      emit(SocialLikePostErrorState());
    });
  }


  //  Chat
  List<UserModel> users = [];
  void getUsers() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if(element.data()['uId'] != uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUserSuccess());
    }).catchError((error) {
      emit(SocialGetAllUserError());
    });
  }


  // Chat Details
  void sendMessage({
    required String text,
    required String dateTime,
    required String receiverId,
  }){
    MessageModel messageModel = MessageModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: userModel!.uId,
        text: text
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }
  List<MessageModel> messages =[] ;

  void getMessage({
    required String receiverId,
  }){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages =[];
      for (var element in event.docs.reversed) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }

  bool isDark=false;
  void changeDark(){
    isDark =! isDark;
    emit(ChangeMode());
  }


}