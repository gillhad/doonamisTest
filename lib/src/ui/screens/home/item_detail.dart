
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/models/item_info.dart';


class ItemDetail extends ConsumerWidget {
  ItemDetail({required this.itemInfo,Key? key}) : super(key: key);

  late SeriesItem itemInfo;
  //String itemId;


//   final serie = FutureProvider.autoDispose<SeriesItem>((ref) async{
//   final cancelToken = CancelToken();
//   ref.onDispose(cancelToken.cancel);
//   await Future<void>.delayed(const Duration(milliseconds: 250));
//   if (cancelToken.isCancelled) throw Exception;
//   final repository =  ref.watch(seriesRepository);
//   //final serieReponse = await repository.fetchItem(itemId,cancelToken);
//   return serieReponse;
// });

  @override
  void initState() {

  }



@override
Widget build(BuildContext context, WidgetRef ref) {
   // itemInfo = ref.watch(seriesRepository).fetchItem(itemId, CancelToken());
    _getItem(ref);
  final repository =  ref.watch(seriesRepository);
 if(itemInfo!=null) {
   print(itemInfo);
 }
    return Scaffold(
      appBar: _appBar(),
      body:  _content(context,ref),
    );
  }

  AppBar _appBar(){
    return AppBar();
  }
  Widget _content(context,ref){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 17),
      child: Column(
        children: [
          Row(
            children: [
              //_image(ref),
              Column(
                children: [
                  //_valorationInfo(context)
                ],
              )
            ],
          ),
          Column(
            children: [
             // _serieInfo()
            ],
          )
        ],
      ),
    );
  }

  Widget _image(ref){
    return Container(
      height: 200,
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage("ref.read(serie).name"))
      ),
    );
  }

  Widget _valorationInfo(BuildContext context){
    return Column(
      children: [
        Text(itemInfo.voteAverage.toString(),
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
                  itemCount: itemInfo.voteAverage.toInt(),
                  itemBuilder: (context,index){return Icon(Icons.star, color: AppStyles.secondary,);}),
            )
          ],),
        ),
        Row(
          children: [
            Text("Popularidad: "),
            Text(itemInfo.popularity.toString())
          ],
        )
      ],
    );
  }

  Widget _serieInfo(){
    return Container();
  }

  _getItem(ref)async {

  }
}



// List<Genre> genres = [];
// var jsonGenres = json["genres"];
// jsonGenres.forEach((genre){
// genres.add(Genre.fromJson(genre));
// });