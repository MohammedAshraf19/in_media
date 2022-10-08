import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/shared/style/fonts_manager.dart';
import 'package:in_media/shared/style/icon_broken.dart';

import '../../layout/socia_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/colors_manager.dart';
import '../../shared/style/route_animation.dart';
import '../../shared/style/style_manager.dart';
import '../../shared/style/values_manager.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){
        if(state is SocialCreatePostSuccessState){
          SocialLayoutCubit.get(context).removePostImage();
          textController.text = '';
          SocialLayoutCubit.get(context).posts = [];
          SocialLayoutCubit.get(context).getPosts();
          Navigator.pushReplacement(context, SlidAnimation(
              page: const SocialLayout(), alignment: AppConstant.topAlignment)
            );
        }
      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, SlidAnimation(
                    page: const SocialLayout(), alignment: AppConstant.topAlignment),);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: ColorManager.primary,
              ),

            ),
            title: Text(
              'New Post',
              style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s22),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    if(SocialLayoutCubit.get(context).postImage ==null){
                      SocialLayoutCubit.get(context).createPost(
                          dateText: now.toString(),
                          text: textController.text
                      );
                    }
                    else{
                      SocialLayoutCubit.get(context).uploadPostImage(dateText: now.toString(), text: textController.text);
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: ColorManager.primary.withOpacity(0.9),
                        fontSize: FontSize.s16
                    ),
                  )
              ),
              const SizedBox(
                width: AppSize.s4,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s20),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(backgroundColor: ColorManager.primary,),
                  if(state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s25,
                        backgroundImage: NetworkImage(
                          SocialLayoutCubit.get(context).userModel!.image!,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s16,
                      ),
                      Text(
                        SocialLayoutCubit.get(context).userModel!.name!,
                        style:  Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: textController,
                      decoration:  InputDecoration(
                        hintText: 'what is on your mind ...',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            color: ColorManager.grey
                        ),
                        filled: false,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  if(SocialLayoutCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height:400.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s4,),
                            image: DecorationImage(
                              image: FileImage(SocialLayoutCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: AppSize.s20,
                            child: Icon(
                              Icons.close,
                              size: AppSize.s16,
                            ),
                          ),
                          onPressed: ()
                          {
                            SocialLayoutCubit.get(context).removePostImage();
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: ()
                          {
                            SocialLayoutCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: ColorManager.primary,
                              ),
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              Text(
                                'add photo',
                                style: TextStyle(
                                    color: ColorManager.primary
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
