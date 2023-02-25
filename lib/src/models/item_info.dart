class ItemInfo{
  String? posterPath;
  late double popularity;
  late int id;
  String? backdropPath;
  late double voteAverage;
  late String overview;
  late String firstAirDate;
  late List<String> genreIds;
  late List<String> originCountry;
  late String originalLanguage;
  late int voteCount;
  late String name;
  late String originalName;

  ItemInfo.fromJson(Map<String,dynamic> json){
    posterPath = json["poster_path"];
    popularity = json["popularity"];
    id = json["id"];
    backdropPath = json["backdrop_path"];
    voteAverage = json["vote_average"];
    overview = json["overview"];
    firstAirDate = json["first_air_date"];
    genreIds = json["genre_ids"];
    originCountry = json["origin_country"];
    originalLanguage = json["original_language"];
    voteAverage = json["vote_average"];
    name = json["name"];
    originalName = json["original_name"];
  }
}