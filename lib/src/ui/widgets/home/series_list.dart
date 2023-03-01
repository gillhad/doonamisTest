import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/models/item_info.dart';

import 'series_card.dart';

class ListaSeries extends ConsumerWidget {

  List<SeriesItem>? _series = [];
  String currentPage = "1";
final _scrollController = ScrollController();

  final _seriesOptions = FutureProvider.autoDispose<List<SeriesItem>>((ref) async{
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (cancelToken.isCancelled) throw Exception;
    final repo = ref.watch(seriesRepository);
    final serieResponse = await repo.fetchSeries(cancelToken);
    return serieResponse;
  });
  _scrollListener() {

      print(_scrollController.position.pixels);

  }
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(_seriesOptions, (previous, next) async{
      _series = ref.watch(seriesRepository).lista;

    });
    if(_scrollController.positions.isNotEmpty) {
      print(_scrollController.position);
    }
   return ListView.separated(
     padding: EdgeInsets.symmetric(vertical: 8),
     shrinkWrap: true,
     controller:  _scrollController,
     //physics: NeverScrollableScrollPhysics(),
     itemCount: ref.watch(seriesRepository).lista.isNotEmpty ? ref.watch(seriesRepository).lista.length : 0,
     itemBuilder: (context,index){
       return SeriesCard(itemInfo:ref.watch(seriesRepository).lista[index]);
     }, separatorBuilder: (BuildContext context, int index) {
     return SizedBox(height: 10,); },);
    throw UnimplementedError();
  }
}