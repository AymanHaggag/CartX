import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConditionalBuilder(
          condition: ShopCubit.get(context).categoriesModel != null,
          builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => products(
                    ShopCubit.get(context).categoriesModel!.data!.data[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount:
                    ShopCubit.get(context).categoriesModel!.data!.data.length,
              ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator())),
    );
  }

  Widget products(DataModel data) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image(
                height: 150,
                width: 150,
                image: NetworkImage(data.image as String)),
            const SizedBox(
              width: 10,
            ),
            Text(
              data.name as String,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_outlined)),
          ],
        ),
      );
}
