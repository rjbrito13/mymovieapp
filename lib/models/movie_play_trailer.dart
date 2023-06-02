import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'movie_loading.dart';
import 'movie_play_dialog.dart';

class MoviePlayTrailer extends StatefulWidget {
  final String title;
  final String videoid;

  const MoviePlayTrailer({Key? key, required this.videoid,required this.title}) : super(key: key);

  @override
  State<MoviePlayTrailer> createState() => _MoviePlayTrailerState();
}

class _MoviePlayTrailerState extends State<MoviePlayTrailer> with SingleTickerProviderStateMixin{
    List<Movie> filteredMovies = [];

  
  List<String> videoid = [];


  bool isDataLoading = true;

    late AnimationController _animationController;



    @override
  void initState() {
    super.initState();
  
    fetchData();
    

   
  }

   Future<void> fetchData() async {
    // Simulate loading data from an API or other source
    await Future.delayed(const Duration(seconds: 1));

    // Set the loaded data
    setState(() {

       _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

  


    loadMoviesFromJson();
    
      isDataLoading = false; // Set loading state to false
    });
  }


@override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void loadMoviesFromJson() async {
   final jsonString = await rootBundle.loadString('assets/movies.json');
    final parsedMovies = parseMoviesFromJson(jsonString);
    setState(() {
      filteredMovies = parsedMovies;
     
    });
  }

   List<Movie> parseMoviesFromJson(String jsonString) {
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}


  


  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final videoid = widget.videoid;


      return Scaffold(
  appBar: AppBar(
    title: Text(title),
  ),
  body: isDataLoading
      ? const MovieLoadingScreen()
      : MoviePlayDialog(title: title,videoid:videoid,)

      );
    
    
    
    
  }
}