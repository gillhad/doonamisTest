import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
      required this.originCountry,
      required this.originalLanguage,
      required this.voteCount,
      required this.name,
      required this.originalName});

  SeriesItem.fromJson(Map<String, dynamic> json) {

    posterPath = json["poster_path"];
    popularity = json["popularity"];
    id = json["id"];
    backdropPath = json["backdrop_path"];
    voteAverage = json["vote_average"].toDouble();
    genreIds = json["genre_ids"];
    overview = json["overview"];
    firstAirDate = json["first_air_date"];
    originCountry = json["origin_country"];
    originalLanguage = json["original_language"];
    voteCount = json["vote_count"];
    name = json["name"];
    originalName = json["original_name"];
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

///Clase con la info detallada de cada serie
class SerieDetail{
late int id;
String? name;
String? nextEpisode;
late List<CreatedBy> createdBy;
late List<Genre> genreList;
 bool? inProduction;
 List<String>? langauges;
 String? lastAirDate;
 String? lastEpisodeToAir;
 int? numberEpisodes;
 int? numberSeasons;
 String? originalLanguage;
 String? originalName;
 String? overview;
 double? popularity;
 double? voteAverage;
 int? voteCount;
 String? posterPath;


SerieDetail.fromJson(Map<String,dynamic> json){
  List<Genre> genres = [];
  List<CreatedBy> createdList = [];

  var jsonGenres = json["genres"];
  if(jsonGenres!=null) {
    jsonGenres.forEach((genre) {
      genres.add(Genre.fromJson(genre));
    });
  }

  var jsonCreated = json["created_by"];
  if(jsonCreated!=null) {
    jsonCreated.forEach((created) {
      createdList.add(CreatedBy.fromJson(created));
    });
  }

print( json["last_episode_to_air"]);
  id = json["id"];
  name = json["name"];
  nextEpisode = json["next_episode"];
  createdBy = createdList;
  genreList = genres;
  inProduction = json["in_production"];
  langauges = json["langauges"];
  lastAirDate = json["last_air_date"];
  lastEpisodeToAir = json["last_episode_to_air"]["name"];
  print(json["number_of_episodes"]);
  numberEpisodes = json["number_of_episodes"];
  numberSeasons = json["number_of_seasons"];
  originalName = json["original_name"];
  originalLanguage = json["original_language"];
  overview = json["overview"];
  popularity = json["popularity"];
  voteAverage = json["vote_average"];
voteCount = json["vote_count"];
posterPath = json["poster_path"];
}
}

class CreatedBy{
  late int id;
  late String name;

  CreatedBy.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
  }
}


class SeriesListResponse extends StateNotifier<List<SeriesItem>>{
   late int totalCount;
   late List<SeriesItem> seriesList;
  SeriesListResponse({required this.totalCount,required this.seriesList}):super([]);

  SeriesListResponse.fromJson(Map<String,dynamic> json):super([]){
    totalCount = json["totalCount"];
    seriesList = json["seriesList"];
  }

}

 final seriesRepository = Provider(SeriesRepository.new);

class SeriesRepository extends StateNotifier<int>{

  SeriesRepository(this.ref):super(0);

  static final repoState = StateProvider((ref) {

    return SeriesRepository(ref).lista.length;
  });

  final Ref ref;
  final _seriesList = <String, SeriesItem>{};
  List<SeriesItem> lista = [];
  int currentPage = 1;
  bool _isLoading = false;

  getList(){
    lista.clear();
    return lista;
  }

  //Get new discoveries
  Future<List<SeriesItem>> fetchSeries(CancelToken cancelToken, {bool? pagination}) async {
    if(pagination!=null){
      _isLoading = false;
    }
    print("siguiente búsqueda");
    print(currentPage);
    if(!_isLoading) {
      _isLoading = true;
      print(currentPage);
      final _response = await ApiClient.get(
          "/tv/popular?page=$currentPage",
          cancelToken: cancelToken);
      print("asd");
      final _responseString = _response.toString();
      final json = jsonDecode(_responseString);
      print(json["results"][0]);
      json["results"].forEach((serie) {
        if (!lista.contains(serie)) {
          lista.add(SeriesItem.fromJson(serie));
        }
      });
      print(lista.length);
      ref.read(repoState.notifier).state = lista.length;
      if (currentPage < json["total_pages"]) {
        currentPage++;
      }
      return lista;
    }
    return [];
  }

  ///Get item detail by ID
  Future<SerieDetail> fetchItem(String id,CancelToken cancelToken)async{


    final _response = await ApiClient.get("/tv/$id");
    String responseString = _response.toString();
    final json = jsonDecode(responseString);
    return SerieDetail.fromJson(json);
  }

}


