import 'package:flutter/material.dart';

import 'blocs/MoviesBloc.dart';
import 'models/Movie.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.black, accentColor: Colors.pinkAccent,),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: Text('Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<MovieModel> snapshot) {
          if (snapshot.hasData) {
            return buildMoviesList(snapshot,context);
          } else if (snapshot.hasError) {
            return Center(child: ErrorWidget(snapshot.error.toString()));
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildMoviesList(AsyncSnapshot<MovieModel> snapshot,BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double itemWidth = .5*width;
    double itemHeight = .2*height;
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: itemWidth/itemWidth*.6,crossAxisCount: 2),
      itemCount: snapshot.data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieCard(
          snapshot: snapshot,
          index: index,
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final AsyncSnapshot<MovieModel> snapshot;
  final int index;

  MovieCard({@required this.snapshot, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                width: double.infinity,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
              ),
            ),
            Text(snapshot.data.results[index].title,style: TextStyle(color: Colors.white,fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
