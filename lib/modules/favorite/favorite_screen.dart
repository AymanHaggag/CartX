import 'package:catrx/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/shop_states.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).favoritesModel!.data! ;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoritesSuccessfulState ){
          ShopCubit.get(context).getFavorites();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body:ConditionalBuilder(
            condition: ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
            builder: (BuildContext context) =>ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context , index)=>ProductUnit(
                name: model.data![index].product!.name,
                image: model.data![index].product!.image,
                price: model.data![index].product!.price,
                oldPrice: model.data![index].product!.oldPrice,
                discount: model.data![index].product!.discount,
                cartOnPressed: (){
                  ShopCubit.get(context).changeCart(model.data![index].product!.id as int);
                  ShopCubit.get(context).getCart();
                },
                favoriteOnPressed: (){
                  ShopCubit.get(context).changeFavorites(model.data![index].product!.id as int);
                  ShopCubit.get(context).getFavorites();
                },
                favoriteIconColorCondition: ShopCubit.get(context).favoritesMap[model.data![index].product!.id],
                cartIconColorCondition: ShopCubit.get(context).cartMap[model.data![index].product!.id],
              ),
              separatorBuilder: (context , index)=>const SizedBox(width: 3),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (BuildContext context) =>const Center(child: Text("Your Favorite List is Empty")),
          ),
        );
      },
    );
  }

}
