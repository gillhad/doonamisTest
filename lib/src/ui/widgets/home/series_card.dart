

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/config/arguments.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';
import 'package:sillicon_films/src/models/item_info.dart';
import 'package:sillicon_films/src/models/movie_genre.dart';
import 'package:sillicon_films/src/ui/screens/home/home.dart';

class SeriesCard extends ConsumerWidget {
  SeriesItem itemInfo;

  SeriesCard({required this.itemInfo,Key? key}) : super(key: key);

  List<Genre>? _genreList = [];



  String genres = "";



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _genreList = ref.watch(repositoryGenreProvider).genreList;

    return GestureDetector(
      onTap: ()async{
        Navigator.pushNamed(context, NavigationRoutes.detail, arguments: DetailArguments(serie:  await ref.watch(seriesRepository).fetchItem(itemInfo.id.toString(),CancelToken())));
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppStyles.primaryContainer,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              children: [
                Container(
                  height: 85,
                  width: 60,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: itemInfo.posterPath!=null ? DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/${itemInfo.posterPath!}")) : null,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width*.6,
                        child: Text(itemInfo.name,style: AppStyles.textTheme.titleMedium,)),
                    SizedBox(height: 5,),
                    ref.watch(repositoryGenreProvider).genreList.isNotEmpty ? Text(getGenre(itemInfo.genreIds)) : Container(),
                    Container(
                        width: MediaQuery.of(context).size.width*.6,
                        child: Text(itemInfo.overview, overflow: TextOverflow.ellipsis,maxLines: 2,)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 8,
              right: 8,
              child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppStyles.secondaryContainer,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: AppStyles.onSecondaryContainer,size: 15,),
                      Text(itemInfo.voteAverage.toString(), style: AppStyles.textTheme.bodyMedium!.copyWith(color: AppStyles.onSecondaryContainer),),
                    ],
                  )))
        ],
      ),
    );
  }

getGenre(List<dynamic> list){
    List<Genre> genreValue = [];
    if(_genreList!.isNotEmpty) {
      list.forEach((element) {
        genreValue.add(_genreList!.singleWhere((id) => element == id.id));
      });
    }
    String concatenate = "";
    genreValue.forEach((element) {
      concatenate = concatenate + element.name;
    });
    return concatenate;
}
}
