import 'package:catrx/layout/cubit/shop_cubit.dart';
import 'package:catrx/layout/cubit/shop_states.dart';
import 'package:catrx/models/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title:                   Center(
                child: Text(
                  "FAQs",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600,color: Colors.white),
                ),
              ),

            ),
            body: ListView.builder(
              itemCount: ShopCubit.get(context).faqModel!.data!.data!.length,
                itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(ShopCubit.get(context).faqModel!.data!.data![index].question as String),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(ShopCubit.get(context).faqModel!.data!.data![index].answer as String),
                    ),
                  ],
                );
                }));
      },
    );
  }
}



Widget FAQUnit(FAQItem faqItem) {
  return ExpansionTile(
    title: Text(faqItem.question as String),
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(faqItem.answer as String),
      ),
    ],
  );
}
