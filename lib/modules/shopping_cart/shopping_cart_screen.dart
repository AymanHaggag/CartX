import 'package:catrx/models/cart_model.dart';
import 'package:catrx/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/shop_states.dart';


class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeCartSuccessfulState ){
          ShopCubit.get(context).getCart();
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).cartModel!.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text("Shopping Cart"),
          ),
          body:ConditionalBuilder(
            condition: ShopCubit.get(context).cartModel!.data!.cartItems!.isNotEmpty,
            builder: (BuildContext context) =>ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context , index)=>ProductUnit(
                name: model.cartItems![index].product!.name,
                image: model.cartItems![index].product!.image,
                price: model.cartItems![index].product!.price,
                oldPrice: model.cartItems![index].product!.oldPrice,
                discount: model.cartItems![index].product!.discount,
                cartOnPressed: (){
                  ShopCubit.get(context).changeCart(model.cartItems![index].product!.id as int);
                  ShopCubit.get(context).getCart();
                },
                favoriteOnPressed: (){
                  ShopCubit.get(context).changeFavorites(model.cartItems![index].product!.id as int);
                  ShopCubit.get(context).getFavorites();
                },
                favoriteIconColorCondition: ShopCubit.get(context).favoritesMap[model.cartItems![index].product!.id],
                cartIconColorCondition: ShopCubit.get(context).cartMap[model.cartItems![index].product!.id],
              ),
              separatorBuilder: (context , index)=>const SizedBox(width: 3),
              itemCount: ShopCubit.get(context).cartModel!.data!.cartItems!.length),
            fallback: (BuildContext context) =>const Center(child: Text("Your Cart List is Empty")),
          ),
        );
      },
    );
  }

}
