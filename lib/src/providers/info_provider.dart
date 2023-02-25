import 'package:sillicon_films/src/models/item_info.dart';

class InfoProvider{
  List<ItemInfo> listItems = [];
  
  getItem(int itemid){
    return listItems.singleWhere((element) => element.id == itemid);
  }

}