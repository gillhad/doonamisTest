import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/models/item_info.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail>  {
  late ItemInfo _itemInfo;
  @override
  void initState() {
    _itemInfo = ItemInfo.mockInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body:  _content(),
    );
  }

  AppBar _appBar(){
    return AppBar();
  }
  Widget _content(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 17),
      child: Column(
        children: [
          Row(
            children: [
              _image(),
              Column(
                children: [
                  _valorationInfo()
                ],
              )
            ],
          ),
          Column(
            children: [
              _serieInfo()
            ],
          )
        ],
      ),
    );
  }

  Widget _image(){
    return Container(
      height: 200,
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(_itemInfo.posterPath!))
      ),
    );
  }

  Widget _valorationInfo(){
    return Column(
      children: [
        Text(_itemInfo.voteAverage.toString(),
          style: TextStyle(color: AppStyles.onBackground, fontSize: 40,),),
        Container(
          width: MediaQuery.of(context).size.width/2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            SizedBox(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _itemInfo.voteAverage.toInt(),
                  itemBuilder: (context,index){return Icon(Icons.star, color: AppStyles.secondary,);}),
            )
          ],),
        ),
        Row(
          children: [
            Text("Popularidad: "),
            Text(_itemInfo.popularity.toString())
          ],
        )
      ],
    );
  }

  Widget _serieInfo(){
    return Container();
  }
}
