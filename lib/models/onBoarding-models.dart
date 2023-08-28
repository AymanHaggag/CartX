
import 'package:catrx/style/themes/themes_conestants.dart';
import 'package:flutter/material.dart';

class BoardingModel {
  final String? boardingImage;
  final String? boardingTitle;
  final String? boardingBody;

  BoardingModel({
    required this.boardingImage,
    required this.boardingTitle,
    required this.boardingBody,
  });

}

Widget boardingUnit (BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding:  EdgeInsets.only(top: 100,bottom: 50),
      child: Image(
        image: AssetImage('${model.boardingImage}'),
      ),
    ),
    Text(
      '${model.boardingTitle}',
      style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: defaultColor),
    ),
    const SizedBox(
      height: 15,
    ),
    Text(
      '${model.boardingBody}',
      style:  TextStyle(fontSize: 15,color: defaultColor),
    ),
  ],
);







