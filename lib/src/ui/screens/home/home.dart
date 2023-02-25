import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/models/item_info.dart';
import 'package:sillicon_films/src/models/movie_genre.dart';
import 'package:sillicon_films/src/ui/widgets/home/series_card.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ItemInfo> _itemList = [];
  final _scrollController = ScrollController();
  int _filterIndex = 0;
  List<String> _genreOptions = [];
  List<MovieGenre> _genreList = [];

  @override
  void initState() {
    _itemList.add(ItemInfo.mockInfo());
    _itemList.add(ItemInfo.mockInfo());
    _itemList.add(ItemInfo.mockInfo());
    _genreList.add(MovieGenre(id: 1, name: "Thriller"));
    _genreList.add(MovieGenre(id: 2, name: "Comedy"));
    _genreList.add(MovieGenre(id: 3, name: "Terror"));
    _scrollController.addListener(() {
     _scrollListener();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                    return RawChip(
                      onPressed: (){
                        if(_genreOptions.contains(_genreList[index].id.toString())){
                          setState(() {
                            _genreOptions.remove(_genreList[index].id.toString());
                          });
                        }else {
                          setState(() {
                            _genreOptions.add(_genreList[index].id.toString());
                          });
                        }
                        _genreOptions.forEach((element) { print(element);});
                      },
                      label: Text(_genreList[index].name),
                      backgroundColor: _genreOptions.contains(_genreList[index].id.toString()) ? AppStyles.secondaryContainer : Colors.grey,);
                  },
                      separatorBuilder: (context,index){return SizedBox(width: 5,);},
                      itemCount: _genreList.length),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context,index){
              return SeriesCard(itemInfo:_itemList[0]);
            }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10,); },),
          ),
        ],
      ),
    );
  }

  _scrollListener(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
     //next page
    }



  }
}
