import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/shop_states.dart';
import '../../models/categories_model.dart';
import '../../models/home_Model.dart';
import '../../shared/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessfulState) {
          if (!state.model.status) {
            showToast(ShopCubit.get(context).addRemoveFavoriteModel!.message,
                ToastStates.error);
          }
        }
        if (state is ShopChangeCartSuccessfulState) ;
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
      HomeModel homeModel, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data?.banners
                .map((item) => CarouselCard(
                      thumbnailUrl: item.image,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              viewportFraction: 0.8,
              initialPage: 0,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => categoryUnit(
                        categoriesModel.data!.data[index], context),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 0),
                    itemCount: categoriesModel.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Popular Products",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1 / 1.15,
              shrinkWrap: true,
              //دي علشان الغي ال اسكرول بتاع الجريد فيو واشتغل اسكرول بالسينجل اتشايلد اسكرول فيو
              physics: const NeverScrollableScrollPhysics(),
              // دي بتعمللي ليست من ويدجيت علي بمعلوميه الانديكس
              children: List.generate(
                  homeModel.data!.products.length,
                  (index) => ProductUnit(
                        name: homeModel.data!.products[index].name,
                        image: homeModel.data!.products[index].image,
                        price: homeModel.data!.products[index].price,
                        oldPrice: homeModel.data!.products[index].oldPrice,
                        discount: homeModel.data!.products[index].discount,
                        cartOnPressed: (){
                          ShopCubit.get(context).changeCart(homeModel.data!.products[index].id as int);
                          ShopCubit.get(context).getCart();
                        },
                        favoriteOnPressed: (){
                          ShopCubit.get(context).changeFavorites(homeModel.data!.products[index].id as int);
                          ShopCubit.get(context).getFavorites();
                        },
                        favoriteIconColorCondition: ShopCubit.get(context).favoritesMap[homeModel.data!.products[index].id],
                        cartIconColorCondition: ShopCubit.get(context).cartMap[homeModel.data!.products[index].id],
                      )
                  /*productUnit(homeModel.data!.products[index], context)*/
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryUnit(DataModel data, context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 120,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(data.image as String),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 130,
          height: 25,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            data.name as String,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  /*Widget productUnit(ProductsModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image as String),
                width: double.infinity,
                height: 200, // fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Discount ${model.discount}%",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  child: Text(
                    model.name as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.2),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${model.price}",
                      style: const TextStyle(
                          fontSize: 12, height: 1.2, color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.oldPrice}",
                        style: const TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id as int);
                        ShopCubit.get(context).getFavorites();

                        debugPrint("${model.id}");
                      },
                      icon: const Icon(Icons.favorite),
                      color:
                          ShopCubit.get(context).favoritesMap[model.id] as bool
                              ? Colors.red
                              : Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeCart(model.id as int);
                        ShopCubit.get(context).getCart();
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                      ),
                      color: ShopCubit.get(context).cartMap[model.id] as bool
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}
