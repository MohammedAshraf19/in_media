import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/shared/components/components.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/fonts_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';

import '../../shared/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          condition: SocialLayoutCubit.get(context).posts.isNotEmpty && SocialLayoutCubit.get(context).userModel !=null,
          builder: (context)=> SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                  itemBuilder:(context,index)=>homeBuild(context,index),
                  separatorBuilder: (context,index)=>const SizedBox(
                    height: AppSize.s3,
                  ),
                  scrollDirection:Axis.vertical ,
                  itemCount:SocialLayoutCubit.get(context).posts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
          fallback: (context)=>Center(child:circularIndicator(color: ColorManager.primary)),
        );
      },
    );
  }
}
Widget homeBuild(context,index)=>Column(
  children: [
    Card(
      margin: const EdgeInsets.all(AppSize.s8),
      elevation: AppSize.s4,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: AppSize.s20,
                  backgroundImage: NetworkImage(
                    '${SocialLayoutCubit.get(context).posts[index].image}',
                  ),
                ),
                const SizedBox(
                  width: AppSize.s12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          SocialLayoutCubit.get(context).posts[index].name!,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          width: AppSize.s3,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: AppSize.s14,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s3,
                    ),
                    Text(
                        SocialLayoutCubit.get(context).posts[index].dateTime!,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: FontSize.s12,
                        )
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s4,
            ),
            Container(
              width: double.infinity,
              height: 1,
              padding: const EdgeInsets.all(AppSize.s20),
              color: Colors.deepOrange[100],
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            if(SocialLayoutCubit.get(context).posts[index].text !='')
              Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.s4,horizontal: AppSize.s4),
              child: Wrap(
                children: [
                  Text(
                    SocialLayoutCubit.get(context).posts[index].text!,
                    style:SocialLayoutCubit.get(context).posts[index].postImage !=''?
                    Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: FontSize.s16):
                    Theme.of(context).textTheme.displayMedium ,
                  ),
                ],
              ),
            ),
            if(SocialLayoutCubit.get(context).posts[index].postImage !='')
              Padding(
                padding: const EdgeInsets.only(top: AppSize.s10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:  Image(
                      image:NetworkImage(
                        SocialLayoutCubit.get(context).posts[index].postImage!,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: AppSize.s400,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.s8,horizontal: AppSize.s3),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      SocialLayoutCubit.get(context).likePost(SocialLayoutCubit.get(context).posId[index]);
                      SocialLayoutCubit.get(context).posts =[];
                      SocialLayoutCubit.get(context).likes =[];
                      SocialLayoutCubit.get(context).posId =[];
                      SocialLayoutCubit.get(context).getPosts();
                    },
                    child: const Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: AppSize.s35,
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.s8,
                  ),
                  Text(
                    '${SocialLayoutCubit.get(context).likes[index]}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: FontSize.s16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);
