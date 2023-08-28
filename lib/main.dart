import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:catrx/modules/splash_screen/splash_screen.dart';
import 'package:catrx/shared/bloc_observer.dart';
import 'package:catrx/shared/constant.dart';
import 'package:catrx/shared/local/sheared_preferances.dart';
import 'package:catrx/style/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/cubit/shop_cubit.dart';
import 'layout/cubit/shop_states.dart';
import 'layout/home_screen.dart';
import 'modules/login/cubit/user_cubit.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  isDark = await CacheHelper.getData(key: "isDark") ?? false;
  onBoarding = await CacheHelper.getData(key: "onboarding");
  token = await CacheHelper.getData(key: "token");

  if (onBoarding != null) {
    openingScreen = LoginScreen();
    if (token != null) {
      openingScreen = const HomeScreen();
    }
  }
  debugPrint(token);

  runApp(MyApp(openingScreen));
}

class MyApp extends StatelessWidget {
  Widget openingScreen;

  MyApp(this.openingScreen, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => UserCubit()..getProfile()),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()
              ..getFAQs()
                ..getCart()
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopChangeThemeState) {
            isDark = ShopCubit.get(context).isDark;
          }
        },
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: /*AnimatedSplashScreen(
                splash: Text("WELCOME",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                nextScreen: openingScreen,
                splashTransition: SplashTransition.fadeTransition,
              ) */ /*openingScreen*/
                  SplashScreen());
        },
      ),
    );
  }
}
