import 'package:flutter/material.dart';
import 'package:sillicon_films/src/models/item_info.dart';
import 'package:sillicon_films/src/ui/widgets/home/series_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ItemInfo> _itemList = [];
  @override
  void initState() {
    _itemList.add(ItemInfo.mockInfo());
    _itemList.add(ItemInfo.mockInfo());
    _itemList.add(ItemInfo.mockInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("home");
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar(){
    return AppBar(
      title: Text("listado de peliculas"),
    );
  }

  Widget _content(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context,index){
              return SeriesCard(itemInfo:_itemList[index]);
            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10,); },),
          ),
        ],
      ),
    );
  }
}
