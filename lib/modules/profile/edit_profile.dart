import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/shared/components/components.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';
import '../../shared/style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController =TextEditingController();
  var bioController =TextEditingController();
  var phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){
        if(state is SocialGetUserDataSuccess) {
          SocialLayoutCubit.get(context).removeProfileImage();
          SocialLayoutCubit.get(context).removeCoverImage();
          Navigator.pop(context);

        }
      },
      builder: (context,state){
        var cubit = SocialLayoutCubit.get(context);
        var profileImage =cubit.profileImage;
        var coverImage = cubit.coverImage;
        nameController.text = cubit.userModel!.name!;
        bioController.text =cubit.userModel!.bio!;
        phoneController.text = cubit.userModel!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: ColorManager.primary.withOpacity(0.8),
                ),
                onPressed: (){
                  Navigator.pop(context);
                }
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: AppSize.s20
              ),
            ),
            actions: [
              TextButton(
                onPressed:(){
                  cubit.updateUser(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                } ,
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    color: ColorManager.primary.withOpacity(0.9),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s14,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is SocialUpdateProfileLoadingState)
                  LinearProgressIndicator(backgroundColor: ColorManager.primary,),
                if(state is SocialUpdateProfileLoadingState)
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: coverImage == null ? Image.network(
                                cubit.userModel!.cover!
                                ,fit: BoxFit.cover
                                ,height: 140,
                                width: double.infinity,
                              )
                                  : Image.file(File(coverImage.path)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppSize.s16),
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: ColorManager.primary,
                                child: IconButton(
                                    icon:  Icon(
                                      IconBroken.Camera,
                                      color: ColorManager.white,
                                      size: AppSize.s16,
                                    )
                                    , onPressed: (){
                                  cubit.getCoverImage();
                                }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            child:
                            cubit.profileImage == null?  CircleAvatar(
                              radius: 62,
                              backgroundImage:   NetworkImage(
                                  cubit.userModel!.image!
                              ),
                            )
                                :CircleAvatar(
                              radius: 62,
                              backgroundImage: FileImage(profileImage!),
                            ) ,
                          ),
                          CircleAvatar(
                            radius: 19,
                            backgroundColor: ColorManager.primary,
                            child: IconButton(
                                icon:  Icon(
                                  IconBroken.Camera,
                                  color: ColorManager.white,
                                  size: AppSize.s16,
                                )
                                , onPressed: (){
                              cubit.getProfileImage();
                            }
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                if(cubit.profileImage!=null||(cubit.coverImage!=null))
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s12),
                    child: Row(
                      children: [
                        if(cubit.profileImage!=null)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius:  BorderRadius.circular(AppSize.s12),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: TextButton(
                                onPressed: (){
                                  cubit.uploadProfileImage(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                                },
                                child: const Text(
                                  'UPLOAD PROFILE',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        if(cubit.coverImage!=null)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius:  BorderRadius.circular(AppSize.s12),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              padding: EdgeInsetsDirectional.zero,
                              child: TextButton(
                                onPressed: (){
                                  cubit.uploadProfileCover(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                                },
                                child:  Text(
                                  'UPLOAD COVER',
                                  style: TextStyle(
                                      color: ColorManager.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                  child: textFormFiled(
                      textController:nameController ,
                      hintText: 'Name',
                      perfixIcon: const Icon(
                          IconBroken.User
                      ),
                      ValidationText: 'Name',
                      type: TextInputType.name
                  ),
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                  child: textFormFiled(
                      textController:bioController ,
                      hintText: 'Bio',
                      perfixIcon: const Icon(
                          IconBroken.Info_Circle
                      ),
                      ValidationText: 'Bio',
                      type: TextInputType.text
                  ),
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                  child: textFormFiled(
                      textController:phoneController ,
                      hintText: 'Phone',
                      perfixIcon: const Icon(
                          IconBroken.Call
                      ),
                      ValidationText: 'Phone',
                      type: TextInputType.phone
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
