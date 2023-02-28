import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sillicon_films/src/connection/api_client.dart';
import 'package:sillicon_films/src/models/movie_genre.dart';

class SeriesItem {
  String? posterPath;
  late double popularity;
  late int id;
  String? backdropPath;
  late double voteAverage;
  late String overview;
  late String firstAirDate;
  late List<dynamic> genreIds;
  late List<Genre>? genreList;
  late List<dynamic> originCountry;
  late String originalLanguage;
  late int voteCount;
  late String name;
  late String originalName;

  SeriesItem(
      {required this.id,
      this.posterPath,
      required this.popularity,
      this.backdropPath,
      required this.voteAverage,
      required this.overview,
      required this.firstAirDate,
      required this.genreIds,
        this.genreList,
      required this.originCountry,
      required this.originalLanguage,
      required this.voteCount,
      required this.name,
      required this.originalName});

  SeriesItem.fromJson(Map<String, dynamic> json) {
    List<Genre> genres = [];
    //
    // var jsonGenres = json["genre_ids"];
    // jsonGenres.forEach((genre){
    //   genres.add(Genre.fromJson(genre));
    // });
    //

    posterPath = json["poster_path"];
    popularity = json["popularity"];
    id = json["id"];
    backdropPath = json["backdrop_path"];
    voteAverage = json["vote_average"].toDouble();
    print("a por los genres");
    genreIds = json["genre_ids"];
    print("genres correctos");
    genreList = genres;
    overview = json["overview"];
    firstAirDate = json["first_air_date"];
    originCountry = json["origin_country"];
    originalLanguage = json["original_language"];
    voteCount = json["vote_count"];
    name = json["name"];
    originalName = json["original_name"];
    print("genero el item");
  }



  static mockInfo() {
    return SeriesItem(
        id: 1,
        posterPath:
            "https://static.posters.cz/image/1300/posters/pulp-fiction-cover-i1288.jpg",
        popularity: 3,
        voteAverage: 3,
        overview: "overview",
        firstAirDate: "02/02/2021",
        genreIds: ["comdedia,terror"],
        originCountry: ["Spain"],
        originalLanguage: "Spanish",
        voteCount: 4,
        name: "La película",
        originalName: "The film");
  }
}



class SeriesListResponse extends StateNotifier<List<Genre>>{
   late int totalCount;
   late List<SeriesItem> seriesList;
  SeriesListResponse({required this.totalCount,required this.seriesList}):super([]);

  SeriesListResponse.fromJson(Map<String,dynamic> json):super([]){
    totalCount = json["totalCount"];
    seriesList = json["seriesList"];
  }

}

final seriesRepository = Provider(SeriesRepository.new);

class SeriesRepository extends StateNotifier<List<SeriesItem>>{
  SeriesRepository(this.ref):super([]);

  final Ref ref;
  final _seriesList = <String, SeriesItem>{};
  List<SeriesItem> lista = [];
  int currentPage = 1;


  //Get new discoveries
  Future<List<SeriesItem>> fetchSeries(CancelToken cancelToken, {String? pagination}) async {
    final _response = await ApiClient.get("/tv/popular",queryParameter: {"page":pagination}, cancelToken: cancelToken);
    final _responseString= _response.toString();
    print(_responseString);
    final json = jsonDecode(_responseString);
    json["results"].forEach((serie) {
      lista.add(SeriesItem.fromJson(serie));
    });
    if(currentPage<json["total_pages"]){
      currentPage++;
    }
    return lista;
  }

  ///Get item detail by ID
  Future<SeriesItem> fetchItem(String id,CancelToken cancelToken)async{
    if(_seriesList.containsKey(id)){
      return _seriesList[id]!;
    }

    final _response = await ApiClient.get("/tv/$id");
    String responseString = _response.toString();
    print(_response);
    final json = jsonDecode(responseString);
    return SeriesItem.fromJson(json);
  }

}


