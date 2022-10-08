import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/modules/login_screen/login_screen.dart';
import 'package:in_media/modules/register_screen/cubit/cubit.dart';
import 'package:in_media/modules/register_screen/cubit/states.dart';
import 'package:in_media/shared/components/constants.dart';
import 'package:in_media/shared/style/fonts_manager.dart';
import 'package:lottie/lottie.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/socia_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/asset_manager.dart';
import '../../shared/style/colors_manager.dart';
import '../../shared/style/icon_broken.dart';
import '../../shared/style/route_animation.dart';
import '../../shared/style/values_manager.dart';

class RegisterScreen extends StatelessWidget {


  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey =GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialCreateUserSuccess) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              showToast(txt: 'Access Login', state: ToastState.SUCCESS);
              uId = CacheHelper.getData(key: 'uId');
              SocialLayoutCubit.get(context).getPosts();
              SocialLayoutCubit.get(context).getUserData();
              Navigator.pushReplacement(context, SlidAnimation(
                  page: const SocialLayout(), alignment: AppConstant.topAlignment),);
            });
          }
          else if(state is SocialCreateUserError){
            showToast(txt: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context,state){
          var cubit = SocialRegisterCubit.get(context);
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
                          Lottie.asset(AssetManager.register),
                          textFormFiled(
                            hintText: 'Name',
                            textController: nameController,
                            perfixIcon: const Icon(
                                IconBroken.User1
                            ),
                            ValidationText: 'Name',
                            type: TextInputType.name,
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),

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
                                  cubit.suffixIcon,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          textFormFiled(
                            hintText: 'Phone',
                            textController: phoneController,
                            perfixIcon: const Icon(IconBroken.Call),
                            ValidationText: 'Phone',
                            type: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: AppSize.s25,
                          ),
                          BuildCondition(
                            condition: state is! SocialRegisterLoading,
                            builder: (context){
                              return InkWell(
                                onTap: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                child: Container(
                                  height: AppSize.s40,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(AppSize.s25),
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
                                      "Login",
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
                            height: AppSize.s20,
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
                            height: AppSize.s20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context,SlidAnimation(page: LoginScreen(),alignment: AppConstant.leftAlignment),);
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
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: FontSize.s22,
                                    fontWeight: FontWeight.bold,
                                    color:ColorManager.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s70,
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
