import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_media/layout/cubit/cubit.dart';
import 'package:in_media/layout/cubit/states.dart';
import 'package:in_media/modules/splash_screen/splash_screen.dart';
import 'package:in_media/shared/bloc_observer.dart';
import 'package:in_media/shared/components/constants.dart';
import 'package:in_media/shared/network/local/cache_helper.dart';
import 'package:in_media/shared/style/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLayoutCubit()..getUserData()..getPosts()..getUsers(),
      child: BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getAppTheme(),
            darkTheme: darkAppTheme(),
            home:   const SplashScreen(),
              themeMode:SocialLayoutCubit.get(context).isDark?ThemeMode.dark :ThemeMode.light,
          );
        },
        listener: (context,state){},
      ),
    );
  }
}