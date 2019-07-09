import 'package:bloc_app/src/models/Movie.dart';

import 'MovieApiProvider.dart';

class Repository {
  final movieApiProvider = new MovieApiProvider();

  Future<MovieModel> fetchAllMovies() => movieApiProvider.fetchMoviesList();
}
