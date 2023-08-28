import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/shop_states.dart';
import '../../models/search_model.dart';
import '../../shared/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is! ShopLoadingState) {}
        //   if (ShopCubit.get(context).userModel!.status) {
        //     print(ShopCubit.get(context).userModel!.message);
        //     // CacheHelper.saveData(
        //     //     key: "token",
        //     //     value: ShopLoginCubit.get(context).userModel.data?.token);
        //     showToast(
        //         ShopCubit.get(context).userModel!.message,
        //         ToastStates.success);
        //   }
        //   else {
        //     print(ShopCubit.get(context).userModel!.message);
        //     showToast(ShopCubit.get(context).userModel!.message,
        //         ToastStates.error);
        //   }
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Search",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      prefix: Icons.short_text,
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your Name';
                        }
                      },
                      label: "Search",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                        condition: state is! ShopLoadingState,
                        builder: (context) => defaultButton(
                            title: "Search",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).search(searchController.text);
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator())),
                    const SizedBox(
                      height: 20,
                    ),
                    if(ShopCubit.get(context).searchModel != null)
                    Container(
                      color: Colors.grey[300],
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: 1 / 1.5,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        //دي علشان الغي ال اسكرول بتاع الجريد فيو واشتغل اسكرول بالسينجل اتشايلد اسكرول فيو
                        children: List.generate(
                            ShopCubit.get(context).searchModel!.data!.data.length,
                                (index) => productUnit(ShopCubit.get(context).searchModel!.data!.data[index],context)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget productUnit(SearchData model ,context) {
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
                height: 150, // fit: BoxFit.cover,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
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
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id as int);
                        ShopCubit.get(context).getFavorites();

                        debugPrint("${model.id}");
                      },
                      icon: const Icon(
                          Icons.favorite),
                      color: ShopCubit.get(context).favoritesMap[model.id] as bool ? Colors.red : Colors.grey ,
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
