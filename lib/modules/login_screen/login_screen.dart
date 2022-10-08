import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/socia_layout.dart';
import 'package:in_media/modules/login_screen/cubit/cubit.dart';
import 'package:in_media/modules/login_screen/cubit/states.dart';
import 'package:in_media/modules/register_screen/register_screen.dart';
import 'package:in_media/shared/components/components.dart';
import 'package:in_media/shared/components/constants.dart';
import 'package:in_media/shared/style/asset_manager.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/fonts_manager.dart';
import 'package:in_media/shared/style/route_animation.dart';
import 'package:in_media/shared/style/values_manager.dart';
import 'package:lottie/lottie.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/icon_broken.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey =GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginError){
            showToast(txt: state.error.toString(), state: ToastState.ERROR);
          }
          if(state is SocialLoginSuccess) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              showToast(txt: 'Access Login', state: ToastState.SUCCESS);
              uId = CacheHelper.getData(key: 'uId');
              SocialLayoutCubit.get(context).getPosts();
              SocialLayoutCubit.get(context).getUserData();
              Navigator.pushReplacement(context, SlidAnimation(
                  page: const SocialLayout(), alignment: AppConstant.topAlignment)
                );
            });
          }
        },
        builder: (context,state){
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(AssetManager.login),
                          textFormFiled(
                            hintText: 'Email',
                            textController: emailController,
                            perfixIcon: const Icon(
                              Icons.supervised_user_circle_rounded,
                            ),
                            ValidationText: 'Email',
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          textFormFiled(
                            hintText: 'Password',
                            textController: passwordController,
                            perfixIcon: const Icon(
                                IconBroken.Password
                            ),
                            ValidationText: 'Password',
                            type: TextInputType.visiblePassword,
                            secure: cubit.passwordVisibility,
                            suffixIcon: IconButton(
                              onPressed: (){
                                cubit.showPasswordVisibility();
                              },
                              icon:  Icon(
                                  cubit.suffixIcon
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          BuildCondition(
                            condition:state is! SocialLoginLoading,
                            builder: (context){
                              return InkWell(
                                onTap: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userLogin(email: emailController.text, password: passwordController.text);
                                  }
                                },
                                child: Container(
                                  height: AppSize.s40,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorManager.primary.withOpacity(0.2),
                                        spreadRadius: AppSize.s3,
                                        blurRadius: AppSize.s4,
                                        offset: const Offset(0, AppSize.s3),
                                      ),
                                    ],
                                  ),
                                  child:   Center(
                                    child: Text(
                                      "LOGIN",
                                      style:  TextStyle(
                                        fontSize: FontSize.s22,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            fallback: (context){
                              return  circularIndicator(color: ColorManager.primary);
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          Text(
                            "OR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: FontSize.s22,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: ColorManager.primary,
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s25,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context,SlidAnimation(page: RegisterScreen(),alignment: AppConstant.rightAlignment),);
                            },
                            child: Container(
                              height: AppSize.s40,
                              decoration: BoxDecoration(
                                color: ColorManager.black,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSize.s25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.grey.withOpacity(0.2),
                                    spreadRadius: AppSize.s3,
                                    blurRadius: AppSize.s4,
                                    offset: const Offset(0, AppSize.s3),
                                  ),
                                ],
                              ),
                              child:   Center(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    fontSize: FontSize.s22,
                                    fontWeight: FontWeight.bold,
                                    color:ColorManager.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
