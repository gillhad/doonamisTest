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

  ItemInfo({
    required this.id,
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
    required this.originalName
  });

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

  static mockInfo(){
    return ItemInfo(id: 1,posterPath: "https://static.posters.cz/image/1300/posters/pulp-fiction-cover-i1288.jpg", popularity: 3, voteAverage: 3, overview: "overview", firstAirDate: "02/02/2021", genreIds: ["comdedia,terror"], originCountry: ["Spain"], originalLanguage: "Spanish", voteCount: 4, name: "La película", originalName: "The film");
  }
}

