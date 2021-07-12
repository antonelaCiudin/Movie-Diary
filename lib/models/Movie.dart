class Movie {
  final String title;
  final String year;
  final String type;
  final String poster;
  final String imdbID;
  final String runtime;
  final String genre;

  Movie({this.title, this.year, this.type, this.poster, this.imdbID, this.runtime, this.genre});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['Title'],
        year: json['Year'],
        type: json['Type'],
        poster: json['Poster'],
        imdbID: json['imdbID'],
        runtime: json['Runtime'],
        genre: json['Genre']);
  }

  Map<String, dynamic> toMap() {
    return {
      'Title': title,
      'Year': year,
      'Poster': poster,
      'imdbID': imdbID,
      'Type':type,
      'Runtime': runtime,
      'Genre': genre
    };
  }

  @override
  String toString() {
    return 'Movie{title: $title, year: $year, type: $type, imdbID: $imdbID, runtime: $runtime, genre: $genre}';
  }
}