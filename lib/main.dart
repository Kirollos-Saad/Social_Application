import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_application/layout/cubit/cubit.dart';
import 'package:social_application/modules/social_login/social_login_screen.dart';
import 'package:social_application/shared/bloc_observer.dart';
import 'package:social_application/shared/cubit.dart';
import 'package:social_application/shared/states.dart';
import 'package:social_application/shared/styles/themes.dart';
import '../network/cache_helper.dart';
import '../network/dio_helper.dart';
import 'layout/social_layout.dart';
import 'shared/components.dart';



void main() async
{  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: FirebaseOptions(
      apiKey: 'AIzaSyDVDUTxdT7r39RxHsHqbnXMGKZCfJ1PV3c',
      appId: '1:1063429749538:android:9a10162bf6dc9a5ff2c37b',
      messagingSenderId: '1063429749538',
      projectId: 'social-application-9959d'
  ),
);
Bloc.observer = MyBlocObserver();
await DioHelper.init();
await CacheHelper.init();
uId = CacheHelper.getData(key: 'uId') ?? '';

runApp(MyApp());
}


// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build

  @override
  Widget build(BuildContext context)
   {

    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context)=> AppCubit(),),
        BlocProvider(create:(context)=>SocialCubit()..getUserData()..getPosts()),

      ],

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return   MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: SocialLoginScreen(),
          );

        },
      ),
    );
  }
}