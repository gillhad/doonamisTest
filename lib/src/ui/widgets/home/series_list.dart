import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sillicon_films/src/models/item_info.dart';

import 'series_card.dart';

class ListaSeries extends ConsumerStatefulWidget {
  const ListaSeries({Key? key}): super(key: key);
  @override
  ListaSeriesState createState() => ListaSeriesState();
}

  class ListaSeriesState extends ConsumerState<ListaSeries>{

  List<SeriesItem>? _series = [];
  String currentPage = "1";
  final _scrollController = RefreshController();
  bool _infoRead = false;

  static final seriesOptions = FutureProvider.autoDispose<List<SeriesItem>>((ref) async{
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) throw Exception;
  final repo = ref.watch(seriesRepository);
  final serieResponse = await repo.fetchSeries(cancelToken);
  return serieResponse;
  });


  @override
  Widget build(BuildContext context) {
    ref.listen(SeriesRepository.repoState, (previous, next) {
      print("hay cambios");
    });

    if (!_infoRead) {
      _infoRead = true;
      print(_infoRead);
      ref.watch(seriesRepository).fetchSeries(CancelToken());
    }

    ref.listen(seriesOptions, (previous, next) async {
      _series = ref
          .watch(seriesRepository)
          .lista;
      print("???");
    });

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ref
          .watch(SeriesRepository.repoState),
      itemBuilder: (context, index) {
        return SeriesCard(
            itemInfo: ref
                .watch(seriesRepository)
                .lista[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10, child: Text(ref
            .read(seriesRepository)
            .lista
            .length
            .toString()));
      },);
  }



}

