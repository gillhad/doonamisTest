
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/config/app_lozalizations.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/models/item_info.dart';

import '../../widgets/home/info_card.dart';


class ItemDetail extends ConsumerWidget {
  ItemDetail({required this.itemInfo,Key? key}) : super(key: key);

  late SerieDetail itemInfo;

  @override
  void initState() {

  }



@override
Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _appBar(context),
      body:  _content(context,ref),
    );
  }

  AppBar _appBar(context){
    return AppBar(
      // title: Text(AppLocalizations.of(context)!.getString("serie_detail")!),
      centerTitle: false,
    );
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
          Text("${AppLocalizations.of(context)!.getString("votes")!}: "),
          Text(itemInfo.voteCount.toString(), style: AppStyles.textTheme.bodyLarge,)
        ],),
        Row(
          children: [
            Text("${AppLocalizations.of(context)!.getString("popularity")!}: "),
            Text(itemInfo.popularity.toString(),style: AppStyles.textTheme.bodyLarge)
          ],
        )
      ],
    );
  }

  Widget _serieInfo(context){
    return Column(
      children: [
        infoCard(AppLocalizations.of(context)!.getString("name")!, itemInfo.name ?? "", context),
        infoCard(AppLocalizations.of(context)!.getString("original_name")!, itemInfo.originalName ?? "", context),
        infoCard(AppLocalizations.of(context)!.getString("genres")!, itemInfo.genreList.fold("", (value, genre) => value + "${genre.name},"), context),
        infoCard(AppLocalizations.of(context)!.getString("summary")!, itemInfo.overview ?? "", context),
        infoCard(AppLocalizations.of(context)!.getString("seasons_lenght")!, itemInfo.numberSeasons.toString(), context),
        infoCard(AppLocalizations.of(context)!.getString("episodes_lenght")!, itemInfo.numberEpisodes.toString(), context),
        infoCard(AppLocalizations.of(context)!.getString("original_language")!, itemInfo.originalLanguage ?? "", context),
        infoCard(AppLocalizations.of(context)!.getString("in_production")!, itemInfo.inProduction!
            ? AppLocalizations.of(context)!.getString("yes")!
            : AppLocalizations.of(context)!.getString("finished")!, context),
        infoCard(AppLocalizations.of(context)!.getString("created_by")!, itemInfo.createdBy.fold("", (value, element) => value+"${element.name},"), context),
        infoCard(AppLocalizations.of(context)!.getString("last_chapter")!, itemInfo.lastEpisodeToAir ?? "", context),
        itemInfo.nextEpisode!=null ? infoCard(AppLocalizations.of(context)!.getString("next_chapter")!, itemInfo.nextEpisode!, context) : Container(),
        infoCard(AppLocalizations.of(context)!.getString("last_air_apisode")!, itemInfo.lastAirDate!, context)
      ],
    );
  }
  



}
