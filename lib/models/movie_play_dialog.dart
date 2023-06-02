import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayDialog extends StatefulWidget {
  final String videoid;
  final String title;

  const MoviePlayDialog({Key? key, required this.videoid,required this.title}) : super(key: key);

  @override
  State<MoviePlayDialog> createState() => _MoviePlayDialogState();
}

class _MoviePlayDialogState extends State<MoviePlayDialog> {
  late YoutubePlayerController  _controller;

  final TextEditingController _textEditingController = TextEditingController();

  bool _isTextFieldEmpty = true;


  @override
void initState() {
  super.initState();

  // Lock screen orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  // Replace 'youtube_video_id' with the actual YouTube video ID
  _controller = YoutubePlayerController(
    initialVideoId: widget.videoid.toString(),
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
}

  @override
  void dispose() {
    _controller.dispose();

     SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }


   void _cleartextfield() {
  setState(() {
    _textEditingController.text = "";
    _isTextFieldEmpty = true;
    
  });
}


  @override
  Widget build(BuildContext context) {

    //final title = widget.title;
      
  return WillPopScope(
      // Handle back button press
      onWillPop: () async {
        // Reset screen orientation to system default
        SystemChrome.setPreferredOrientations([]);
        return true; // Allow back navigation
      },
    child:
  
  
  Scaffold(

      body: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          YoutubePlayer(
        aspectRatio: 16/9,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent

        ),

        const SizedBox(height: 20,),

        const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.star),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Reviews',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic)),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                  width: 370.0,
                  child: TextField(
                    maxLines: null,
                    controller: _textEditingController,
                    onChanged: (value) {
                      _isTextFieldEmpty = value.isEmpty;

                      if (_isTextFieldEmpty) {
                        _isTextFieldEmpty = true;
                      } else {
                        _isTextFieldEmpty = false;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Insert your review here",
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        suffixIcon: IconButton(
                          icon: _isTextFieldEmpty
                              ? const Icon(Icons.send,color: Colors.blue,)
                              : const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            if (_isTextFieldEmpty) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Colors.blue,
                                  title: const Text(
                                    "Search Field is Empty",
                                    style: TextStyle(color: Colors.black),
                                  ),
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
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              _cleartextfield();
                            }
                          },
                        )),
                  )),
            ),
            const Expanded(child: 
             SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:   Column(
            children: [
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.red,
                  child: Text("T"),
                ),
                title: Text('Trisha'),
                subtitle: Text('5 stars'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  """Easily the best Spider-Man film ever made so far. 
                  No Way Home is a near perfect culmination of the three generations of spider man and even takes inspiration from the PS4 game at moments ,
                  this movie exceeds all expectations with its emotional range and action sequences and gives new meaning to this Spider-Man trilogy 
                  and gives Holland the true mantel of Spider-Man.
                  
                  """,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Divider(), // Optional divider to separate comments
              ListTile(
                leading: CircleAvatar(
                   child: Text("R"),
                ),
                title: Text('Roy James'),
                subtitle: Text('4 stars'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                   """I think anyone who rated a 1 star is mentally unstable. I say this often as a joke, but I loved this movie so deeply that, this once, I am not joking. It was such a tremendous work of art -- of directing, of acting, of editing, and especially of writing -- that I almost can't believe it exists.
                  """,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Divider(), // Optional divider to separate comments
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.orange,
                   child: Text("T"),
                ),
                title: Text('Tom Holland'),
                subtitle: Text('4 stars'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'The most awaited movie of 2021 turned out to be an absolute masterpiece!  with the hype and wait being worth it.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Divider(), // Optional divider to separate comments
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.green,
                   child: Text("L"),
                ),
                title: Text('Luffy'),
                subtitle: Text('4 stars'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'This has been the most satisfactory crossover film in Marvel History for hardcore fans of MCU, and indeed a remarkable Film for general...this has been a promising film, which has freaking goosebumps stuff! And the most incredible characters that Marvel Studios brought into the world ever together!',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
            )
            )

      ],)
      
      
      
  
  )
  );
}
}