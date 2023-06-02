import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:convert';
import 'movie.dart';

import 'movie_details.dart';




class MovieHome extends StatefulWidget {
  final String title;

  const MovieHome({Key? key, required this.title}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
 final TextEditingController _textEditingController = TextEditingController();
 bool _isTextFieldEmpty = true;
 bool _isTextFieldEnabled = true;

 

  
  // List<String> movies = [
  //   'captainamerica.jpg',
  //   'ironman.jpg',
  //   'spidey.jpg',
  //   'thor.jpg',
  //   'venom.jpg'
  // ];

   List<String> movietitle = [
    'Captain America',
    'Ironman',
    'Spidey',
    'Thor',
    'Venom'
  ];

  List<String> filteredMovies = [];
  List<String> filteredTitle = [];
  List<Movie> moviedata = [];
  


  @override
  void initState(){
   
    loadMoviesFromJson();
    filterMovies(_textEditingController.text);

    checkSearchIfEmpty();


   
    super.initState();
  }

   @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }




  void loadMoviesFromJson() async {
    final jsonString = await rootBundle.loadString('assets/movies.json');
    final parsedMovies = parseMoviesFromJson(jsonString);
    setState(() {
      moviedata = parsedMovies;
    });
  }

   List<Movie> parseMoviesFromJson(String jsonString) {
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}



void filterMovies(String searchText) {
  setState(() {
    filteredMovies = moviedata
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.imagePath)
        .toList();

    filteredTitle = moviedata
        .where((movie) =>
            movie.title.toLowerCase().contains(searchText.toLowerCase()))
        .map((e) => e.title)
        .toList();
  });
}




  void checkSearchIfEmpty(){
      _textEditingController.addListener(() {
            setState(() {
               _isTextFieldEmpty = _textEditingController.text.isEmpty;
              

              
            });
       
      });


  }

 void _cleartextfield() {
  setState(() {
    _textEditingController.text = "";
    _isTextFieldEmpty = true;
    _isTextFieldEnabled = true;
    filterMovies(_textEditingController.text);
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
        Hero(tag: title, child: SizedBox(
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
    final String title = widget.title;


    return  Scaffold(
        body:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 16.0),
              child:  Text(
                title,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 60, left: 5.0),
                child: Icon(Icons.favorite_outline))
          ],
        ),
            Padding(
          padding: const EdgeInsets.only(left:15),
          child: SizedBox(
              width: 370.0,
              child: TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  _isTextFieldEmpty = value.isEmpty;
                  

                  if(_isTextFieldEmpty){
                     _isTextFieldEnabled = true;
                      filterMovies(value);
                      

                  }
                  else{
                    filterMovies(value);
                     
                  }

                },
                enabled: _isTextFieldEnabled,
                  decoration:  InputDecoration(
                      hintText: "Spiderman",
                      
                      
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      suffixIcon: IconButton(
                        icon: _isTextFieldEmpty 
                          ? const Icon(Icons.search)
                          : const Icon(Icons.close,color:Colors.red),
                          onPressed: () {

                            if(_isTextFieldEmpty){
                                 showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Colors.blue,
                                  
                                  title: const Text("Search Field is Empty",style: TextStyle(color: Colors.black),),
                                  content: const Text(
                                            "Please enter a text in the field to search for a movie",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontStyle: FontStyle.italic)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.yellow,
                                        
                                        
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("Close",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                            }
                            else{
                               _cleartextfield();
                            }
                             

                          },
                      )
                          
                ),
                      
                      )),
        ),
          
          filteredMovies.isEmpty
          ? const Text("")
          :
          const Padding(
              padding: EdgeInsets.only(top:20, left: 16.0),
              child: Text(
                'Movies Found',
                style: TextStyle(fontSize: 30,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 300,
           
            child: filteredMovies.isEmpty
            ? const Padding(padding: EdgeInsets.only(left:15),
            child: Text ("No movies found",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),),)
            : filteredTitle.isEmpty
            ? const Text ("No movies found",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),)
            : ListView.builder(
              
              scrollDirection: Axis.horizontal,
              
              itemCount: filteredMovies.length,
              itemBuilder: (context,index) {
              
                return Padding(padding: const EdgeInsets.only(left:10,top:10),
                child: box(filteredMovies[index],getRandomColor(),filteredTitle[index]));
              }
            
            
            )


          ),
      ],
    )
      


       
       
    );
  }
}