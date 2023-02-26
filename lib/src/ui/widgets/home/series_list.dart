import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/models/item_info.dart';

import 'series_card.dart';

class ListaSeries extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final List<ItemInfo> _itemList = ref.watch(mainProvider);
   return ListView.separated(
     padding: EdgeInsets.symmetric(vertical: 8),
     shrinkWrap: true,
     physics: NeverScrollableScrollPhysics(),
     itemCount: 5,
     itemBuilder: (context,index){
       return SeriesCard(itemInfo:_itemList[index);
     }, separatorBuilder: (BuildContext context, int index) {
     return SizedBox(height: 10,); },),
    throw UnimplementedError();
  }
}