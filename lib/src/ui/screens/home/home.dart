
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/models/item_info.dart';
import 'package:sillicon_films/src/models/movie_genre.dart';
import 'package:sillicon_films/src/ui/widgets/home/series_list.dart';

import '../../../config/app_styles.dart';


class Home extends ConsumerWidget  {
   Home({Key? key}) : super(key: key);


  List<Genre>? _genreList = [];
  List<SeriesItem>? _itemList = [];
  final _scrollController = ScrollController();

  int _filterIndex = 0;
  final  genreOptions = FutureProvider.autoDispose<List<Genre>>((ref) async{
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (cancelToken.isCancelled) throw Exception;
    final repository =  ref.watch(repositoryGenreProvider);
    final genreResponse = await repository.fetchGenre(cancelToken);
    return genreResponse;
  });

List<Genre> optionsSelecte = [];


  @override
  void initState() {
    _scrollController.addListener(() {
     _scrollListener();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(genreOptions).value;
     ref.listen(genreOptions, (previous, next) async{
       _genreList = ref.watch(repositoryGenreProvider).genreList;

     });

     if(_genreList!=null) {
     }
    return Scaffold(
      appBar: _appBar(),
      body: _content(context, ref),
    );
  }

  AppBar _appBar(){
    return AppBar(
      title: Text("listado de peliculas"),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref){
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 40,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //       itemCount:  ref.watch(repositoryGenreProvider).genreList.isNotEmpty ?  ref.watch(repositoryGenreProvider).genreList.length : 0 ,
          //       itemBuilder: (context,index){
          //     return GestureDetector(
          //       child: Container(
          //           height: 30,
          //           child: Text(ref.watch(repositoryGenreProvider).genreList[index].name)),
          //     );
          //   }),
          // ),
          Flexible(
            child: ListaSeries(),
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
