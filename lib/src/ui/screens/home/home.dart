
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sillicon_films/src/config/app_lozalizations.dart';
import 'package:sillicon_films/src/config/navigation/globals.dart';
import 'package:sillicon_films/src/models/item_info.dart';
import 'package:sillicon_films/src/models/movie_genre.dart';
import 'package:sillicon_films/src/ui/widgets/home/series_list.dart';


class Home extends ConsumerWidget  {
   Home({Key? key}) : super(key: key);


  List<Genre>? _genreList = [];
  List<SeriesItem>? _itemList = [];
  bool _loaded = false;

  int _filterIndex = 0;
  final  genreOptions = FutureProvider.autoDispose<List<Genre>>((ref) async{
      final cancelToken = CancelToken();
      ref.onDispose(cancelToken.cancel);
      await Future<void>.delayed(const Duration(milliseconds: 250));
      if (cancelToken.isCancelled) throw Exception;
      final repository = ref.watch(repositoryGenreProvider);
      final genreResponse = await repository.fetchGenre(cancelToken);
      return genreResponse;

  });

  final repo = FutureProvider.autoDispose<List<SeriesItem>>((ref)async{
    final repository = ref.watch(seriesRepository);
    return repository.lista;
  });

List<Genre> optionsSelecte = [];

final _refresherController = RefreshController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
      ref
          .watch(genreOptions)
          .value;

      ref.listen(repo, (previous, next) {

      });
    return Scaffold(
      appBar: _appBar(context),
      body: _content(context, ref),
    );
  }

  AppBar _appBar(BuildContext context){
    print("context");
    print(context);
    return AppBar(
       title: Text(AppLocalizations.of(context)!.getString("serie_list")!),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref){
ref.listen(ListaSeriesState.seriesOptions, (previous, next) {
});
    return SmartRefresher(
      controller: _refresherController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () async{
        await ref.watch(seriesRepository).fetchSeries(CancelToken(),pagination: true);
        _refresherController.loadComplete();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        //physics: NeverScrollableScrollPhysics(),
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
      ),
    );

  }

}
