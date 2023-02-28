
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/models/item_info.dart';


class ItemDetail extends ConsumerWidget {
  ItemDetail({required this.itemInfo,Key? key}) : super(key: key);

  late SerieDetail itemInfo;

  @override
  void initState() {

  }



@override
Widget build(BuildContext context, WidgetRef ref) {
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
              _image(ref),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _valorationInfo(context)
                ],
              )
            ],
          ),
          Column(
            children: [
             _serieInfo(context)
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
        image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/${itemInfo.posterPath!}"))
      ),
    );
  }

  Widget _valorationInfo(BuildContext context){
    return Column(
      children: [
        Text(itemInfo.voteAverage!.toStringAsFixed(2),
          style: TextStyle(color: AppStyles.secondary, fontSize: 40,),),
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
                  itemCount: itemInfo.voteAverage!.toInt(),
                  itemBuilder: (context,index){return Icon(Icons.star, color: AppStyles.secondary,);}),
            )
          ],),
        ),
        Row(children: [
          Text("Votos: "),
          Text(itemInfo.voteCount.toString(), style: AppStyles.textTheme.bodyLarge,)
        ],),
        Row(
          children: [
            Text("Popularidad: "),
            Text(itemInfo.popularity.toString(),style: AppStyles.textTheme.bodyLarge)
          ],
        )
      ],
    );
  }

  Widget _serieInfo(context){
    return Column(
      children: [
        _infoCard("Nombre:", itemInfo.name ?? "", context),
        _infoCard("Nombre original", itemInfo.originalName ?? "", context),
        _infoCard("Géneros", itemInfo.genreList.fold("", (value, genre) => value + "${genre.name},"), context),
        _infoCard("Resumen", itemInfo.overview ?? "", context),
        _infoCard("Numero de temporadas", itemInfo.numberSeasons.toString(), context),
        _infoCard("Numero de episodios", itemInfo.numberEpisodes.toString(), context),
        _infoCard("Idioma original", itemInfo.originalLanguage ?? "", context),
        _infoCard("En producción", itemInfo.inProduction! ? "Si" : "Acabada", context),
        _infoCard("Creadores", itemInfo.createdBy.fold("", (value, element) => value+"${element.name},"), context),
        _infoCard("Últimno capítulo", itemInfo.lastEpisodeToAir ?? "", context),
        itemInfo.nextEpisode!=null ? _infoCard("Próximo capítulo", itemInfo.nextEpisode!, context) : Container(),
        _infoCard("Fecha del último capitulo:", itemInfo.lastAirDate!, context)
      ],
    );
  }
  
  Widget _infoCard(String title, String value, context){
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


}



// List<Genre> genres = [];
// var jsonGenres = json["genres"];
// jsonGenres.forEach((genre){
// genres.add(Genre.fromJson(genre));
// });