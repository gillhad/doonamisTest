import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';

Container  infoCard(String title, String value, context){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppStyles.primaryContainer
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title:",style: AppStyles.textTheme.labelLarge!.copyWith(color: AppStyles.onPrimaryContainer),),
        SizedBox(width: 5,),
        Flexible(child: Text(value, maxLines: 30,style: AppStyles.textTheme.bodyMedium!.copyWith(color: AppStyles.onPrimaryContainer),))
      ],),
  );
}