import 'package:flutter/material.dart';
import 'package:sillicon_films/src/config/app_styles.dart';
import 'package:sillicon_films/src/config/navigation/navigator_routes.dart';
import 'package:sillicon_films/src/models/item_info.dart';

class SeriesCard extends StatefulWidget {
  ItemInfo itemInfo;
  SeriesCard({required this.itemInfo,Key? key}) : super(key: key);

  @override
  State<SeriesCard> createState() => _SeriesCardState();
}

class _SeriesCardState extends State<SeriesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, NavigationRoutes.detail);
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: widget.itemInfo.posterPath!=null ? DecorationImage(image: NetworkImage(widget.itemInfo.posterPath!)) : null,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width*.6,
                        child: Text(widget.itemInfo.name)),
                    SizedBox(height: 5,),
                    Container(
                        width: MediaQuery.of(context).size.width*.6,
                        child: Text(widget.itemInfo.genreIds.reduce((value, element) =>  value + element))),
                    SizedBox(height: 5,),
                    Container(
                        width: MediaQuery.of(context).size.width*.6,
                        child: Text(widget.itemInfo.overview, overflow: TextOverflow.ellipsis,maxLines: 2,)),
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
                      Text(widget.itemInfo.popularity.toString(), style: AppStyles.textTheme.bodyMedium!.copyWith(color: AppStyles.onSecondaryContainer),),
                    ],
                  )))
        ],
      ),
    );
  }
}
