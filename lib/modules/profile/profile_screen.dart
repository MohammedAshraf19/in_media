import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/modules/profile/edit_profile.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/fonts_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/icon_broken.dart';
import '../../shared/style/route_animation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
       SocialLayoutCubit cubit = SocialLayoutCubit.get(context);
        return BuildCondition(
          condition: cubit.userModel != null,
          builder: (context){
            return Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSize.s8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image:NetworkImage(
                                '${cubit.userModel!.cover}',
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 140,

                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 59,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            '${cubit.userModel!.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Text(
                  '${cubit.userModel!.name}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Text(
                    '${cubit.userModel!.bio}',
                    style:Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 13
                    )
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                /*
                Padding(
                  padding: const EdgeInsets.all(AppSize.s4),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Posts',
                                  style:Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: FontSize.s14
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                '2k',
                                style: TextStyle(
                                    color:  ColorManager.primary,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Followers',
                                  style:Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: FontSize.s14
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                '400',
                                style:  TextStyle(
                                    color:  ColorManager.primary,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s4,
                              ),
                              Text(
                                  'Followings',
                                  style:Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: FontSize.s14
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style:  TextStyle(
                                    color:  ColorManager.primary,
                                    fontSize: FontSize.s17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s4,
                              ),
                              Text(
                                  'Photos',
                                  style:Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: FontSize.s14
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                 */
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){
                            Navigator.push(context, SlidAnimation(
                                page: EditProfileScreen(), alignment: AppConstant.topAlignment
                            ),
                            );
                          },
                          child:  Icon(
                            IconBroken.Edit_Square,
                            color: ColorManager.primary,
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){
                          SocialLayoutCubit.get(context).userModel =null;
                          SocialLayoutCubit.get(context).posts = [];
                          SocialLayoutCubit.get(context).users = [];
                          SignOut(context);
                        },
                        child:  Text(
                          'Log Out',
                          style: TextStyle(
                              color: ColorManager.primary
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          fallback:(context)=> Center(child:circularIndicator(color: ColorManager.primary)),
        );
      },
    );
  }
}
