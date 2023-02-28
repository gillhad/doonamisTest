import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/models/item_info.dart';

import 'series_card.dart';

class ListaSeries extends ConsumerWidget {

  List<SeriesItem>? _series = [];
  String currentPage = "1";

  final _seriesOptions = FutureProvider.autoDispose<List<SeriesItem>>((ref) async{
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (cancelToken.isCancelled) throw Exception;
    final repo = ref.watch(seriesRepository);
    final serieResponse = await repo.fetchSeries(cancelToken);
    return serieResponse;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.watch(seriesRepository).lista.length);
    ref.listen(_seriesOptions, (previous, next) async{
      _series = ref.watch(seriesRepository).lista;
      if(_series!.length>10) {
      }
    });

   return ListView.separated(
     padding: EdgeInsets.symmetric(vertical: 8),
     shrinkWrap: true,
     physics: NeverScrollableScrollPhysics(),
     itemCount: ref.watch(seriesRepository).lista.isNotEmpty ? ref.watch(seriesRepository).lista.length : 0,
     itemBuilder: (context,index){
       return SeriesCard(itemInfo:ref.watch(seriesRepository).lista[index]);
     }, separatorBuilder: (BuildContext context, int index) {
     return SizedBox(height: 10,); },);
    throw UnimplementedError();
  }
}