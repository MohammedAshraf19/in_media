import 'package:flutter/material.dart';
import 'package:in_media/modules/login_screen/login_screen.dart';
import 'package:in_media/shared/style/asset_manager.dart';
import 'package:in_media/shared/style/colors_manager.dart';
import 'package:in_media/shared/style/fonts_manager.dart';
import 'package:in_media/shared/style/style_manager.dart';
import 'package:in_media/shared/style/values_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    bool isLast =false;
    List<BorderShow>border =[
      BorderShow(
          image: AssetManager.onBoardingFirst,
          title: 'It\'s your first step to communicate !',
          body: 'To know the world around you , open our app and Discover the world !'
      ),
      BorderShow(
          image: AssetManager.onBoardingSecond,
          title: 'Chat Here !!',
          body: 'You can chat with your friends  It is top secret conversation  The best place to chat'
      ),
      BorderShow(
          image: AssetManager.onBoardingThird,
          title: 'Photos And Posts',
          body: 'You can add posts or photos as you want Do what you want without any limitation ,but don\'t hurt any one ! Enjoy .'
      ),
      BorderShow(
          image: AssetManager.onBoardingFourth,
          title: 'Reactions And Comments',
          body: 'You can react and comments on posts or photos as you want But remember , don\'t hurt any one !'
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child:  Text(
                'skip',
                style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s22)
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:   [
                      Expanded(
                        child: Lottie.asset(border[index].image),
                      ),
                      const SizedBox(height: AppSize.s30,),
                      Text(
                        border[index].title,
                        style: Theme.of(context).textTheme.displayLarge,

                      ),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      Text(
                        border[index].body,
                        style:Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                    ],
                  );
                },
                itemCount: border.length,
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == border.length-1) {
                    isLast =true;
                  }
                },
              ),
            ),
            const SizedBox(height: AppSize.s40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: border.length,
                  effect:  ExpandingDotsEffect(
                    dotColor: ColorManager.grey,
                    activeDotColor: ColorManager.primary,
                    dotHeight: AppSize.s12,
                    expansionFactor: AppSize.s4,
                    dotWidth: AppSize.s12,
                    spacing: AppSize.s4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast==true){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }
                    else {
                      pageController.nextPage(duration: const Duration(
                          milliseconds: 750
                      ), curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child:  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: ColorManager.white,
                  ),
                  backgroundColor: ColorManager.primary,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
