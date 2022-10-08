import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_media/models/user_model.dart';

import '../../layout/socia_layout.dart';
import '../../shared/style/colors_manager.dart';
import '../../shared/style/icon_broken.dart';
import '../../shared/style/route_animation.dart';
import '../../shared/style/values_manager.dart';

class PersonProfile extends StatelessWidget {
  UserModel model;
  PersonProfile({Key? key,
    required this.model
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
           // Navigator.pushReplacement(context, SlidAnimation(
            //    page: const SocialLayout(), alignment: AppConstant.topAlignment),);
          },
          icon: Icon(
            IconBroken.Arrow___Left_2,
            color: ColorManager.primary,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
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
                          '${model.cover}',
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
                      '${model.image}',
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
            '${model.name}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          Text(
              '${model.bio}',
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
        ],
      ),
    );
  }
}
