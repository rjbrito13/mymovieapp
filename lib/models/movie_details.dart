import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Styles/ovalshapes.dart';
import 'package:movie_app/models/movie_loading.dart';

import 'package:movie_app/models/movie_play_trailer.dart';
import 'dart:convert';
import 'movie.dart';



class MovieDetailsPage extends StatefulWidget {
  final String title;
  final String imagePath;

  const MovieDetailsPage({Key? key, required this.title, required this.imagePath}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}



class _MovieDetailsPageState extends State<MovieDetailsPage> with SingleTickerProviderStateMixin {
  List<Movie> filteredMovies = [];
  List<String> paths = [];
 

  List<String> subtitle = [];
  List<int> releasedate = [];
  List<String> screentime = [];
  List<String> director = [];
  List<String> category = [];
  List<String> videoid = [];
  List<String> titles = [];


  bool isDataLoading = true;


    late AnimationController _animationController;
  late Animation<double> _animation;

  
  @override
  void initState() {
    super.initState();
  
    fetchData();
    filterMovies("");
    

   
  }

   Future<void> fetchData() async {
    // Simulate loading data from an API or other source
    await Future.delayed(const Duration(seconds: 1));

    // Set the loaded data
    setState(() {

       _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 30.0).animate(_animationController);


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
      filterMovies(widget.title);
    });
  }

   List<Movie> parseMoviesFromJson(String jsonString) {
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}


  void filterMovies(String searchText) {
  setState(() {
   
    subtitle = filteredMovies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.subtitle)
        .toList();

     category = filteredMovies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.category)
        .toList();

    

    releasedate = filteredMovies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.releaseDate)
        .toList();
      
    screentime = filteredMovies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.screentime)
        .toList();

    director = filteredMovies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.director)
        .toList();

    videoid = filteredMovies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.videoid)
        .toList();

       titles = filteredMovies.map((movie) => movie.title).toList();

      paths = filteredMovies.map((movie) => movie.imagePath).toList();



  });
}

//widget that shows movie per box in the list builder
  double boxheight = 400;

  Widget box(String movie, Color color,String title) {
    return GestureDetector(
      onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => MovieDetailsPage(
            title: title,
            imagePath: movie,
           
              ))


          );


      },

      child: Column(
      children: [
        Hero(tag: "$title x", child: SizedBox(
          width: 200,
          height: 250,
          child: Center(
            child: Image.asset(
               movie, 
             fit: BoxFit.contain,
            )
          ),
        ),),
         Text(title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
        
        ),
       

      
      ],
    ),


    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }



  @override
  Widget build(BuildContext context) {

    final title = widget.title;
    final path = widget.imagePath;
    
    

  

    return Scaffold(
  appBar: AppBar(
    title: Text(title),
     actions: [
    IconButton(
      icon: const Icon(Icons.home),
      onPressed: () {
         Navigator.popUntil(context, ModalRoute.withName('/'));
      },
    ),
  ],
    
  ),
  body: isDataLoading
      ? const MovieLoadingScreen()
      : SingleChildScrollView(
    child: Column(
      children: [
        GestureDetector(
      onTap: () {
       Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) =>  MoviePlayTrailer(
                videoid: videoid[0].toString(),
                title: title,
          
           
              ))


          );
      },
      child: 

        Hero(
          tag: title,
          child: SizedBox(
            width: 400,
            height: 400,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 72, 250, 2)
                            .withOpacity(0.5),
                        blurRadius: _animation.value,
                        spreadRadius: _animation.value / 5,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: child,
                    ),
                  ),
                );
              },
              child: Image.asset(
                path,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),),
        Row(children: [
           Padding(padding:  const EdgeInsets.only(left:15,top:15),
            child: Align(
                alignment:  Alignment.centerLeft,
                 child: OvalShape(
                  category: category[0].toString(),
                 ),
                 ),
              
           
           ),
            Padding(padding: const EdgeInsets.only(left:15,top:15),
           child:  Text("$title : ${subtitle[0].toString()}"
           ,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
           ),
          
        ],),
        Row(children: [
            const Padding(padding:  EdgeInsets.only(left:15,top:15),
           child:  Text("Director :"
           ,style:  TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 15),),
           ),
           Padding(padding: const EdgeInsets.only(left:5,top:15),
           child:  Text("${director[0].toString()}  |"
           ,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
           ),
           const Padding(padding:  EdgeInsets.only(left:3,top:15),
           child:  Icon(Icons.timer)
           ),
           Padding(padding: const EdgeInsets.only(left:5,top:15),
           child:  Text(screentime[0].toString()
           ,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
           ),
           
          
        ],),

        SizedBox(
          height:50,
          width: 300,
          child: Container(
           
        
          )
        ),
       const Row(
          children: [
              Padding(
                padding:  EdgeInsets.only(left:15,top:15),
                child:  Text("Other videos you might like", 
                style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,decoration: TextDecoration.underline),
              
          ),
        )
          ],
        ),
        
        SizedBox(height: 300,
           
            child: filteredMovies.isEmpty
            ? const Padding(padding: EdgeInsets.only(left:15),
            child: Text ("No movies found",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),),)
            : ListView.builder(
              
              scrollDirection: Axis.horizontal,
              
              itemCount: filteredMovies.length,
              itemBuilder: (context,index) {
              
                return Padding(padding: const EdgeInsets.only(left:10,top:10),
                child: box(paths[index],getRandomColor(),titles[index]));
              }
            
            
            )


          ),


        
        
        
        
      
      ],
    ),
  ),
);

  }
}