import 'package:catrx/modules/FAQs/faq_screen.dart';
import 'package:catrx/test_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/shop_states.dart';
import '../../shared/components.dart';
import '../../shared/local/sheared_preferances.dart';
import '../login/cubit/user_cubit.dart';
import '../login/cubit/user_states.dart';
import '../login/login_screen.dart';
import '../update/update_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
  listener: (context, state) {
    if (state is! ShopLoadingState) {  }
    if(state is UserGetProfileSuccessfulState){  }
  },
  builder: (context, state) {return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Profile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
            SizedBox(height: 20,),
            const ClipOval(
              child: Image(
                height: 120,
                width: 120,
                image: NetworkImage("https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745"),
              ),
            ),
            SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${UserCubit.get(context).userModel?.data?.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text("${UserCubit.get(context).userModel?.data?.email}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),                  ],
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                const Text(
                  "Night Mood",
                  style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
                ),
                const Spacer(),
                Switch(value: ShopCubit.get(context).isDark , onChanged: (value){
                  ShopCubit.get(context).changeTheme();
                }),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeTheme();
                      CacheHelper.saveData(key: "isDark", value: ShopCubit.get(context).isDark);
                    },
                    icon: const Icon(Icons.brightness_6_outlined)
                ),
              ],
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen()
                    ));
                  },
                  child: const Text("Update Profile",style: TextStyle(fontSize: 25),),
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  CacheHelper.deleteData(key: "token").then((value) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) => LoginScreen()
                    ), (route) => false);
                    showToast("logout successful", ToastStates.success);
                  });
                  CacheHelper.deleteData(key: "onboarding");

                },
                child: const Text("Logout",style: TextStyle(fontSize: 25),),
              ),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  FAQsScreen()));
            },
                child: Text(
              "FAQs",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  ProductCard()));
            },
                child: Text(
              "TEST",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  },
);

  }
}
