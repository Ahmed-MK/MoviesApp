import 'dart:async';
import 'package:bloc_app/src/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieApiProvider {
  static const _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  final _apiUrl =
      'http://api.themoviedb.org/3/movie/popular?api_key=' + _apiKey;

  Future<MovieModel> fetchMoviesList() async {
    final response = await http.get(_apiUrl);

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      print('Connection is unavailable');
      throw Exception('Network fetching failed');
    }
  }
}
