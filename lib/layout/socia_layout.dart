import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/modules/new_post_screen/new_post_screen.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/icon_broken.dart';
import 'package:in_media/shared/style/style_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';

import '../shared/components/constants.dart';
import '../shared/style/route_animation.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              cubit.name[cubit.currentIndex],
              style: getBoldStyle(color: ColorManager.primary,fontSize: 20),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                    color: ColorManager.primary,
                  ),
                  onPressed: (){
                    Navigator.pushReplacement(context, SlidAnimation(
                        page: NewPostScreen(), alignment: AppConstant.topAlignment),);
                  }
              ),
              IconButton(
                  icon: Icon(
                    Icons.brightness_medium_outlined,
                    color: ColorManager.primary,
                  ),
                  onPressed: (){
                    SocialLayoutCubit.get(context).changeDark();
                  }
              ),
            ],
          ),
          body:  cubit.screen[cubit.currentIndex],
          bottomNavigationBar:CircleNavBar(
            color:SocialLayoutCubit.get(context).isDark?ColorManager.black :ColorManager.white,
            onChanged: (index) {
              cubit.changeBottomNav(index);
            },
            initIndex: cubit.currentIndex,
            activeIcons:  [
              Icon(IconBroken.Home, color: ColorManager.primary),
              Icon(IconBroken.Chat, color: ColorManager.primary),
              Icon(IconBroken.User1, color: ColorManager.primary),
            ],
            circleWidth: 55,
            height: 60,
            shadowColor: ColorManager.primary,
            elevation: 3,
            inactiveIcons:  [
              Icon(IconBroken.Home, color: ColorManager.primary,size: AppSize.s30),
              Icon(IconBroken.Chat, color: ColorManager.primary,size: AppSize.s30),
              Icon(IconBroken.User1, color: ColorManager.primary,size: AppSize.s30),
            ],
          ) ,
        );
      },
    );
  }
}
