import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/layout/socia_layout.dart';
import 'package:in_media/models/user_model.dart';
import 'package:in_media/modules/profile/person_profile.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';
import '../../models/message_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/icon_broken.dart';
import '../../shared/style/route_animation.dart';

class ChatDetails extends StatelessWidget {
  UserModel useModel;
  ChatDetails({Key? key,
    required this.useModel,
}) : super(key: key);

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialLayoutCubit.get(context).getMessage(receiverId: useModel.uId!);
        return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
          listener: (context, state){},
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                   Navigator.pushReplacement(context, SlidAnimation(
                        page: const SocialLayout(), alignment: AppConstant.topAlignment),);
                  },
                  icon: Icon(
                    IconBroken.Arrow___Left_2,
                    color: ColorManager.primary,
                  ),
                ),
                title: InkWell(
                  onTap: (){
                    Navigator.push(context, SlidAnimation(
                        page:  PersonProfile(model: useModel), alignment: AppConstant.topAlignment),);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s20,
                        backgroundImage: NetworkImage(
                          useModel.image!,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s10,
                      ),
                      Expanded(
                        child: Text(
                          useModel.name!,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.primary
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: BuildCondition(
                condition: true,//SocialLayoutCubit.get(context).messages.length>0,
                fallback: (context) => Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ColorManager.primary,
                    )),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(AppSize.s20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: const ScrollPhysics(),
                             reverse: true,
                             // addRepaintBoundaries:false ,
                              itemBuilder: (context, index) {
                                var message =
                                SocialLayoutCubit.get(context).messages[index];
                                if (SocialLayoutCubit.get(context).userModel!.uId ==
                                    message.senderId) {
                                  return buildMyMessage(message);
                                }
                                return buildMessage(message);
                              },
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              addAutomaticKeepAlives:false,
                              cacheExtent: 100,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              separatorBuilder: (context, index) => const SizedBox(
                                height: AppSize.s10,
                              ),
                              itemCount:
                              SocialLayoutCubit.get(context).messages.length),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            start: AppSize.s10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:SocialLayoutCubit.get(context).isDark?ColorManager.black :ColorManager.white,
                            ),
                            borderRadius: BorderRadius.circular(AppSize.s20),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration:  const InputDecoration(
                                    hintText: 'type message here',
                                    border:OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(AppSize.s10),
                                          topLeft: Radius.circular(AppSize.s10)
                                      ),
                                    ),
                                  ),
                                  controller: textController,
                                ),
                              ),
                              Container(
                                height: AppSize.s50,
                                color: ColorManager.primary,
                                child: MaterialButton(
                                    child: const Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                      size: AppSize.s16,
                                    ),
                                    minWidth: 1,
                                    onPressed: (){
                                      SocialLayoutCubit.get(context).sendMessage(
                                        text: textController.text,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: useModel.uId!,
                                      );
                                      textController.text = '';
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s4, horizontal: AppSize.s10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(AppSize.s10),
          topEnd: Radius.circular(AppSize.s10),
          topStart: Radius.circular(AppSize.s10),
        ),
      ),
      child: Text(
        messageModel.text!,
      ),
    ),
  );
  Widget buildMyMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s4, horizontal: AppSize.s10),
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(AppSize.s10),
          topEnd: Radius.circular(AppSize.s10),
          topStart: Radius.circular(AppSize.s10),
        ),
      ),
      child: Text(
        messageModel.text!,
      ),
    ),
  );
}


