import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search_screen/search_screen.dart';
import '../modules/shopping_cart/shopping_cart_screen.dart';
import 'cubit/shop_cubit.dart';
import 'cubit/shop_states.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("CARTX",style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SearchScreen()));
                  }, icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ShoppingCartScreen()));
                  }, icon: const Icon(Icons.shopping_cart)
              ),

            ],
          ),
          body: ShopCubit.get(context).screensList[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap:(index){ShopCubit.get(context).changeNavigationBar(index);},
            selectedLabelStyle: TextStyle(color: Colors.red ),
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.grey,),
              label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.apps, color: Colors.grey,),
                  label: "Category"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.grey,),
                  label: "Favorites"),
              BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.grey,),
                  label: "Settings"),
            ],

          ) ,
        );
      },
    );
  }
}
