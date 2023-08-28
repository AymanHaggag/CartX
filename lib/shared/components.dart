import 'package:catrx/models/home_Model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/themes/themes_conestants.dart';
import 'constant.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  var onSubmit,
  var onChange,
  var onTap,
  bool isPassword = false,
  required var validate,
  required String label,
  String? hintText,
  IconData? prefix,
  IconData? suffix,
  var suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      cursorColor: defaultColor,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: defaultColor),
        labelText: label,
        labelStyle:  TextStyle(color: defaultColor),
        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
            color: defaultColor,

          ),
        )
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: defaultColor,
          ), ),
        focusedBorder : OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultColor,
            ), ),

      ),
    );


Widget defaultButton ({
  required String title,
  required var onPressed,
}) => Container(
  height: 45,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  width: double.infinity,
  child:   ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.black,
      backgroundColor: defaultColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),

    ),

  ),
)
);

enum ToastStates  {success , error , warning}

Color chooseToastColor (ToastStates state)
{
  Color backGroundColor;

  switch(state){
    case ToastStates.success :
      backGroundColor = Colors.green;
      break;
    case ToastStates.error :
      backGroundColor = Colors.red;
      break;
    case ToastStates.warning :
      backGroundColor = Colors.amberAccent;
      break;
  }
  return backGroundColor;
}

void showToast(String message , ToastStates state ){

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}


void navigationRemove (BuildContext context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => screen
        ),
            (route) => false
    );

class ProductUnit extends StatelessWidget {
   const ProductUnit({
    Key? key,
    required this.cartOnPressed,
    required this.favoriteOnPressed,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.favoriteIconColorCondition,
    required this.cartIconColorCondition,
  }) : super(key: key);

    final VoidCallback cartOnPressed;
   final VoidCallback favoriteOnPressed;
  final String? name;
  final String? image;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final bool? favoriteIconColorCondition;
  final bool? cartIconColorCondition;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(image!),
                width: double.infinity,
                height: 200, // fit: BoxFit.cover,
              ),
              if (discount != 0)
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Discount $discount%",
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
                    name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.2),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "$price",
                      style: const TextStyle(
                          fontSize: 12, height: 1.2, color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (discount != 0)
                      Text(
                        "$oldPrice",
                        style: const TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed:
                        favoriteOnPressed
                      ,
                      icon: const Icon(Icons.favorite),
                      color:
                      favoriteIconColorCondition!
                          ? Colors.red
                          : Colors.grey,
                    ),
                    IconButton(
                      onPressed:
                        cartOnPressed
                      ,
                      icon: const Icon(Icons.shopping_cart,
                      ),
                      color:
                      cartIconColorCondition!
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
  }
}


Widget productUnit({
  required Function cartOnPressed,
  required Function favoriteOnPressed,
  required String name,
  required String image,
  required int price,
  required double oldPrice,
  required double discount,
  required bool favoriteIconColorCondition,
  required bool cartIconColorCondition,
}) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(image),
              width: double.infinity,
              height: 200, // fit: BoxFit.cover,
            ),
            if (discount != 0)
              Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Discount $discount%",
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
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.2),
                ),
              ),
              Row(
                children: [
                  Text(
                    "$price",
                    style: const TextStyle(
                        fontSize: 12, height: 1.2, color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (discount != 0)
                    Text(
                      "$oldPrice",
                      style: const TextStyle(
                          fontSize: 12,
                          height: 1.2,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      favoriteOnPressed;
                    },
                    icon: const Icon(Icons.favorite),
                    color:
                    favoriteIconColorCondition
                        ? Colors.red
                        : Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                     cartOnPressed;
                    },
                    icon: const Icon(Icons.shopping_cart,
                    ),
                    color:
                    cartIconColorCondition
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
}

class CarouselCard extends StatelessWidget {
  final String? thumbnailUrl;

  CarouselCard({
    this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(thumbnailUrl as String),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

