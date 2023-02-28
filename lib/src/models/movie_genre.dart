import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/connection/api_client.dart';


final repositoryGenreProvider = Provider(SeriesGenreRepository.new);

//SeriesGenreRepository seriesGenreRepository(ref)=> SeriesGenreRepository(ref);

class SeriesGenreRepository extends StateNotifier<List<Genre>>{
  //static final seriesGenreProvider = StateNotifierProvider<SeriesGenreRepository, List<Genre>>((ref)=>SeriesGenreRepository(ref));
 // static final seriesGenreProvider = ChangeNotifierProvider((ref)=>SeriesGenreRepository(ref));
  //static final seriesGenreProvider = StateNotifierProvider<SeriesGenreRepository, List<Genre>>((ref)=>SeriesGenreRepository(ref));

  final Ref ref;
  late List<Genre> genreList = [];
  SeriesGenreRepository(this.ref):super(<Genre>[]);

  List get genreListGet{
    return genreList;
  }

  // List<Genre> genreSelected = [];
  //
  // addGenreSelected(Genre genre){
  //   genreSelected.add(genre);
  // }
  //
  // bool isGenreSelected(Genre genre){
  //   if(genreSelected.contains(genre)){
  //     return true;
  //   }
  //   return false;
  // }



  String getGenreNames(List<int> list){
    String genres = "";
    for(var id in list){
      genreList.forEach((genre){
        if(genre.id==id){
          genres = genres + genre.name;
        }
      });
    }
    return genres;
  }


  Future<List<Genre>> fetchGenre(
      CancelToken cancelToken
      ) async {
     final _response = await ApiClient.get(
    '/genre/tv/list', cancelToken: cancelToken
    );
    
    List<Genre> list = [];
    String eing = _response.toString();
    final json = jsonDecode(eing);
    json['genres'].forEach((genre){
      list.add(Genre.fromJson(genre));
    });
    genreList = list;
    print("obtener los genres");
    return list;

}

}


class Genre {

  late int id;
  late String name;

  Genre({required this.id, required this.name});

Genre.fromJson(Map<String,dynamic> json){
  id = json["id"];
  name = json["name"];
}

}

class GenreResponse{
  List<Genre> genres;
   GenreResponse({
  required this.genres});


}

