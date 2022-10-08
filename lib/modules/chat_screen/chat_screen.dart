import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/modules/chat_screen/chat_details.dart';

import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/user_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/route_animation.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          condition: SocialLayoutCubit.get(context).users.isNotEmpty,
          builder: (context)=>ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return buildChat(SocialLayoutCubit.get(context).users[index],context);
            },
            separatorBuilder: (context,index){
              return  Container(
                width: double.infinity,
                height: 1,
                padding: const EdgeInsets.all(AppSize.s20),
                color: Colors.deepOrange[100],
              );
            },
            itemCount: SocialLayoutCubit.get(context).users.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: ColorManager.primary,)),
        );
      },
    );
  }
}
Widget buildChat(UserModel model,context)=>InkWell(
  onTap: (){
    Navigator.pushReplacement(context, SlidAnimation(
        page:  ChatDetails(useModel: model), alignment: AppConstant.topAlignment)
    );
  },
  child:   Padding(
    padding: const EdgeInsets.all(AppSize.s25),
    child: Row(
      children: [
        CircleAvatar(
          radius: AppSize.s25,
          backgroundImage: NetworkImage(
            model.image!,
          ),
        ),
        const SizedBox(
          width: AppSize.s10,
        ),
        Expanded(
          child: Text(
            model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,

          ),
        ),

      ],

    ),

  ),
);